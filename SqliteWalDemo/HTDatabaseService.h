//
//  HTDatabaseService.h
//  HelloTalk_Binary
//
//  Created by zhuzhi on 14-4-21.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSQLBuffer.h"
#import "HTMutableSQLBuffer.h"
#import "HTDatabaseResultSet.h"

@interface HTDatabaseTransaction : NSObject

@property (nonatomic) HTDatabaseOperationType operationType;
@property (nonatomic) HTDatabaseLogicType logicType;
@property (nonatomic, strong) HTSQLBuffer *sqlBuffer;
@property (nonatomic, strong) HTMutableSQLBuffer *mutableSQLBuffer;
@property (nonatomic, strong) HTDatabaseResultSet *resultSet;

- (NSString *)sql;
- (NSArray *)sqls;

@end

@interface HTDatabaseService : NSObject

+ (instancetype)defaultServiceWithUserId:(UInt32)userid;

- (void)readWithTransaction:(HTDatabaseTransaction *)transaction
			completionBlock:(dispatch_block_t)completionBlock;

- (void)writeWithTransaction:(HTDatabaseTransaction *)transaction
				 completionBlock:(dispatch_block_t)completionBlock;

- (void)asyncReadWithTransaction:(HTDatabaseTransaction *)transaction
				 completionBlock:(dispatch_block_t)completionBlock;

- (void)asyncWriteWithTransaction:(HTDatabaseTransaction *)transaction
					  completionBlock:(dispatch_block_t)completionBlock;

@end
