//
//  QCHttpTool.h
//  chargePileManage
//
//  Created by YuMing on 16/6/22.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCHttpTool : NSObject
#if SERVER_TYPE
#pragma - mark bomb data request
+ (void) bombQueryData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;
+ (void) bombQueryData:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;
#pragma - mark bomb chargePile Number request
+ (void) bombQueryCPNumber:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure;
#else

#pragma - mark http data request
+ (void) httpQueryCPNumber:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure;
+ (void) httpQueryCPData:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure;
#endif
@end
