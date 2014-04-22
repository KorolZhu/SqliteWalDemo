//
//  HTDatabaseService.m
//  HelloTalk_Binary
//
//  Created by zhuzhi on 14-4-21.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "HTDatabaseService.h"
#import "FMDatabaseQueue.h"
#import "HTFMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation HTDatabaseTransaction

- (NSString *)sql {
	return self.sqlBuffer.sql;
}

- (NSArray *)sqls {
	NSMutableArray *sqls = [NSMutableArray array];
	if ([[self.mutableSQLBuffer batchSqls] count] > 0) {
		[sqls addObjectsFromArray:[self.mutableSQLBuffer batchSqls]];
	}
	
	if (self.sqlBuffer.sql.length > 0) {
		[sqls addObject:self.sqlBuffer.sql];
	}
	return sqls;
}

@end

@interface HTDatabaseService ()
{
	dispatch_queue_t readQueue;
	dispatch_queue_t writeQueue;
	
	dispatch_queue_t completionQueue;

	HTFMDatabase *readDatabase;
	FMDatabaseQueue *writeDatabaseQueue;
}

@end

@implementation HTDatabaseService

static HTDatabaseService *databaseService = nil;

+ (instancetype)defaultServiceWithUserId:(UInt32)userid {
	if (!databaseService) {
		databaseService = [[self alloc] initWithUserID:userid];
	}
	return databaseService;
}

- (instancetype)initWithUserID:(UInt32)userid {
	self = [super init];
	if (self) {
		NSString *defaultDbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/test.db"];
		readDatabase = [[HTFMDatabase alloc] initWithPath:defaultDbPath];
		writeDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:defaultDbPath];
		
		readQueue = dispatch_queue_create("com.hellotalk.readDbQueue", NULL);
		writeQueue = dispatch_queue_create("com.hellotalk.writeDbQueue", NULL);
		completionQueue = dispatch_queue_create("com.hellotalk.dbCompletionQueue", DISPATCH_QUEUE_CONCURRENT);
		
		[readDatabase open];
	}
	return self;
}

- (dispatch_block_t)readBlockWithTransaction:(HTDatabaseTransaction *)transaction {
	dispatch_block_t block = ^{
		if (transaction.operationType == HTDatabaseOperationTypeQuery) {
			FMResultSet *result =  [readDatabase executeQuery:transaction.sqlBuffer.sql];
			NSMutableArray *resultArr;
			while ([result next]){
				if (!resultArr)
					resultArr = [NSMutableArray array];
				if (result.resultDictionary)
					[resultArr addObject:[result resultDictionary]];
			}
			HTDatabaseResultSet *resultSet = [[HTDatabaseResultSet alloc] init];
			resultSet.resultArray = resultArr;
			resultSet.resultCode = result ? SQLITE_OK : SQLITE_ERROR;
			transaction.resultSet = resultSet;
		} else if (transaction.operationType == HTDatabaseOperationTypeBatchQuery) {
			NSMutableArray *resultArray = [NSMutableArray array];
			BOOL succeed = YES;
			for (NSString *sql in [transaction.mutableSQLBuffer batchSqls]) {
				FMResultSet *result =  [readDatabase executeQuery:sql];
				NSMutableArray *temp = [NSMutableArray array];
				if (result) {
					while ([result next]){
						if (result.resultDictionary)
							[temp addObject:[result resultDictionary]];
					}
				}
				else{
					succeed = NO;
				}
				[resultArray addObject:temp];
			}
			
			HTDatabaseResultSet *resultSet = [[HTDatabaseResultSet alloc] init];
			resultSet.resultArray = resultArray;
            resultSet.resultCode = succeed ? SQLITE_OK : SQLITE_ERROR;
			transaction.resultSet = resultSet;
		}
	};
	
	return block;
}

- (dispatch_block_t)writeBlockWithTransaction:(HTDatabaseTransaction *)transaction {
	dispatch_block_t block = ^{
		[writeDatabaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
			BOOL succeed = YES;
			for (NSString *sql in [transaction sqls]) {
				succeed &= [db executeUpdate:sql];
				if (!succeed) {
					*rollback = YES;
					break;
				}
			}
			
			HTDatabaseResultSet *resultSet = [[HTDatabaseResultSet alloc] init];
			resultSet.resultCode = db.lastErrorCode;
			transaction.resultSet = resultSet;
		}];
	};
	
	return block;
}

- (void)readWithTransaction:(HTDatabaseTransaction *)transaction completionBlock:(dispatch_block_t)completionBlock {
	dispatch_sync(readQueue, ^{
		@autoreleasepool {
			[self readBlockWithTransaction:transaction]();
		}
	});
	
	completionBlock();
}

- (void)writeWithTransaction:(HTDatabaseTransaction *)transaction completionBlock:(dispatch_block_t)completionBlock {
	dispatch_sync(writeQueue, ^{
		@autoreleasepool {
			[self writeBlockWithTransaction:transaction]();
		}
	});
	
	completionBlock();
}

- (void)asyncReadWithTransaction:(HTDatabaseTransaction *)transaction completionBlock:(dispatch_block_t)completionBlock {
	dispatch_async(readQueue, ^{
		@autoreleasepool {
			[self readBlockWithTransaction:transaction]();
			
			completionBlock();
		}
	});
}

- (void)asyncWriteWithTransaction:(HTDatabaseTransaction *)transaction completionBlock:(dispatch_block_t)completionBlock {
	dispatch_async(writeQueue, ^{
		@autoreleasepool {
			[self writeBlockWithTransaction:transaction]();
			
			completionBlock();
		}
	});
}

@end
