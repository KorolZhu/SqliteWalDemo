//
//  HTMutableSQLBuffer.h
//  HelloTalk_Binary
//
//  Created by 任健生 on 13-8-3.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSQLBuffer.h"

@interface HTMutableSQLBuffer : NSObject

@property (nonatomic) Class entity;

- (id)initWithBatchSqls:(NSArray *)batchSqls;
- (NSArray *)batchSqls;

- (void)addBuffer:(HTSQLBuffer *)buffer;

@end
