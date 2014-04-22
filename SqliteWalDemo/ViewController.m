//
//  ViewController.m
//  SqliteWalDemo
//
//  Created by zhuzhi on 14-4-19.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "HTFMDatabase.h"
#import "FMDatabaseQueue.h"
#import "HTDatabaseService.h"

@interface ViewController ()
{
	FMDatabaseQueue *databaseQueue;
    HTFMDatabase *readDatabase;
//    HTFMDatabase *writeDatabase;
	NSString *dbPath;
	
	dispatch_queue_t readQueue;
	dispatch_queue_t writeQueue;

	long long lastReadCount;
	long long readCount;
	long long lastWriteCount;
	long long writeCount;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/test.db"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
		readDatabase = [[HTFMDatabase alloc] initWithPath:dbPath];
		if ([readDatabase open]) {
			[readDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS TEST (id INTEGER PRIMARY KEY AUTOINCREMENT, VALUE INTEGER);"];
			
			for (int i = 0; i < 1000; i++) {
				[readDatabase executeUpdateWithFormat:@"INSERT INTO test VALUES (NULL, %d)", i];
			}
			
			[readDatabase close];
		}
	} else {
//		readDatabase = [[HTFMDatabase alloc] initWithPath:dbPath];
//		databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
	}
	
	
	readQueue = dispatch_queue_create("com.hellotalk.testReadDbQueue", DISPATCH_QUEUE_CONCURRENT);
	writeQueue = dispatch_queue_create("com.hellotalk.testWriteDbQueue", DISPATCH_QUEUE_CONCURRENT);

	[self writeData];
	[self readData];
	
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(count) userInfo:nil repeats:YES];
}

- (void)readData {
	HTDatabaseTransaction *transaction = [[HTDatabaseTransaction alloc] init];

	HTSQLBuffer *sql = [[HTSQLBuffer alloc] init];
	sql.SELECT(@"*").FROM(@"TEST").WHERE(SQLNumberLessOrEqual(@"ID", 50));
	
	transaction.sqlBuffer = sql;
	transaction.operationType = HTDatabaseOperationTypeQuery;
	
//	while (true) {
//		[[HTDatabaseService defaultServiceWithUserId:0] readWithTransaction:transaction completionBlock:^{
//			NSLog(@"query success");
//			NSLog(@"%@", transaction.resultSet.resultArray);
//		}];
//	}
	
	dispatch_async(readQueue, ^{
		while (true) {
			[[HTDatabaseService defaultServiceWithUserId:0] asyncReadWithTransaction:transaction completionBlock:^{
				++readCount;
				if (transaction.resultSet.resultCode == SQLITE_OK) {
//					NSLog(@"query success");
//					NSLog(@"%@", transaction.resultSet.resultArray);
				}

			}];
		}
	});
	
	dispatch_async(readQueue, ^{
		while (true) {
			[[HTDatabaseService defaultServiceWithUserId:0] readWithTransaction:transaction completionBlock:^{
				++readCount;
				if (transaction.resultSet.resultCode == SQLITE_OK) {
					//					NSLog(@"query success");
					//					NSLog(@"%@", transaction.resultSet.resultArray);
				}
				
			}];
		}
	});
	
//	void (^ __block readBlock)() = ^{
//		
//		[[HTDatabaseService defaultServiceWithUserId:0] readWithTransaction:transaction completionBlock:^{
////			NSLog(@"query success");
////			NSLog(@"%@", transaction.resultSet.resultArray);
//		}];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 1"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 2"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 3"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 4"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 5"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 6"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 7"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 8"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 9"];
////		[readDatabase executeQuery:@"SELECT * FROM TEST WHERE ID = 10"];
//
//		++readCount;
//        dispatch_async(readQueue, readBlock);
//    };
//    dispatch_async(readQueue, readBlock);
}

- (void)writeData {
	HTDatabaseTransaction *transaction = [[HTDatabaseTransaction alloc] init];
	
	HTSQLBuffer *sql = [[HTSQLBuffer alloc] init];
	sql.UPDATE(@"TEST").SET(@"VALUE", @(90)).WHERE(@"ID=3");
	
	transaction.sqlBuffer = sql;
	transaction.operationType = HTDatabaseOperationTypeUpdate;
	
	dispatch_async(writeQueue, ^{
		while (true) {
			[[HTDatabaseService defaultServiceWithUserId:0] asyncWriteWithTransaction:transaction completionBlock:^{
				++writeCount;
				if (transaction.resultSet.resultCode == SQLITE_OK) {
//					NSLog(@"write success");
				}
			}];
		}
	});
	
	dispatch_async(writeQueue, ^{
		while (true) {
			[[HTDatabaseService defaultServiceWithUserId:0] writeWithTransaction:transaction completionBlock:^{
				++writeCount;
				if (transaction.resultSet.resultCode == SQLITE_OK) {
					//					NSLog(@"write success");
				}
			}];
		}
	});
	
//	void (^ __block writeBlock)() = ^{
//		[databaseQueue inDatabase:^(FMDatabase *writeDatabase) {
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 1"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 2"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 3"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 4"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 5"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 6"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 7"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 8"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 9"];
//			[writeDatabase executeUpdate:@"UPDATE TEST SET VALUE = 90 WHERE ID = 10"];
//		}];
//
//		++writeCount;
//        dispatch_async(writeQueue, writeBlock);
//    };
//    dispatch_async(writeQueue, writeBlock);
}

- (void)count {
    long long lastRead = lastReadCount;
    long long lastWrite = lastWriteCount;
    lastReadCount = readCount;
    lastWriteCount = writeCount;
    NSLog(@"%lld, %lld", lastReadCount - lastRead, lastWriteCount - lastWrite);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
