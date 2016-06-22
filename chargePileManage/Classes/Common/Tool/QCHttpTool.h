//
//  QCHttpTool.h
//  chargePileManage
//
//  Created by YuMing on 16/6/22.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCHttpTool : NSObject
#pragma - mark bomb data request
+ (void) bombQueryData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;
+ (void) bombQueryData:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;
#pragma - mark bomb chargePile Number request
+ (void) bombQueryCPNumber:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;

@end
