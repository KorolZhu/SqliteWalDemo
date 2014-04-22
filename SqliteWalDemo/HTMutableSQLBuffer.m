//
//  HTMutableSQLBuffer.m
//  HelloTalk_Binary
//
//  Created by 任健生 on 13-8-3.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#import "HTMutableSQLBuffer.h"

@interface HTMutableSQLBuffer () {
    NSMutableArray *sqlBuffers;
}

@end

@implementation HTMutableSQLBuffer


- (id)initWithBatchSqls:(NSArray *)batchSqls {
    
    self = [super init];
    
    if (self) {
        sqlBuffers = [NSMutableArray arrayWithArray:batchSqls];
    }
    
    return self;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        sqlBuffers = [NSMutableArray array];
    }
    
    return self;
}

- (NSArray *)batchSqls {
    NSMutableArray *sqls = [NSMutableArray arrayWithCapacity:sqlBuffers.count];
    for (HTSQLBuffer *buffer in sqlBuffers) {
        [sqls addObject:buffer.sql];
    }
    return sqls;
}

- (void)addBuffer:(HTSQLBuffer *)buffer {
    [sqlBuffers addObject:buffer];
}

@end
