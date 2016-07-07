//
//  QCHttpTool.h
//  chargePileManage
//
//  Created by YuMing on 16/6/22.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CPMAPI_PREFIX                   @"http://192.168.1.111:8080/cpserver/"
#define CPMAPI_PILE_LIST                @"getChargePileList"
#define CPMAPI_PILE_DETAIL              @"getChargePileDetail"
#define CPMAPI_USER_LOGIN               @"userLogin"
#define CPMAPI_HISTORY_INFO             @"getChargePileHistInfo"

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

+ (void) httpQueryData:(NSString *)URLString params:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure;
@end
