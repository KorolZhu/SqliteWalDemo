//
//  HTResultSet.h
//  HelloTalk_Binary
//
//  Created by 任健生 on 13-6-26.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    HTDatabaseResultSetTypeObject = 0,
    HTDatabaseResultSetTypeArray = 1,
    HTDatabaseResultSetTypeFields = 2,
    HTDatabaseResultSetTypeFieldsArray = 3,
    HTDatabaseResultSetTypeOperation = 4,
} HTDatabaseResultSetType;

typedef enum {
    HTDatabaseResultFailed = 0,
    HTDatabaseResultSucceed = 1,
    HTDatabaseResultConstraint,
} HTDatabaseResult;


@interface HTDatabaseResultSet : NSObject

@property (nonatomic) HTDatabaseResultSetType type;
@property (nonatomic) int resultCode;
@property (nonatomic,strong) NSArray *resultArray;
@property (nonatomic,strong) id resultObject;
@property (nonatomic,strong) NSDictionary *resultFields;

@end
