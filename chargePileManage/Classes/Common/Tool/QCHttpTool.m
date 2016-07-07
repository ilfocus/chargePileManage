//
//  QCHttpTool.m
//  chargePileManage
//
//  Created by YuMing on 16/6/22.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCHttpTool.h"
#import <BmobSDK/Bmob.h>
#import "QCPileListDataMode.h"
#import "QCPileListNumModel.h"
#import "AFNetworking.h"

@implementation QCHttpTool

#if SERVER_TYPE
/**
 *  从Bomb调用数据，成功返回充电桩数据数组，失败返回错误信息
 *
 *  @param numOfData 充电桩数据个数
 *  @param success   成功，调用带QCPileListDataMode模型数据数组参数的Block
 *  @param failure   失败，调用错误Block
 */
+ (void) bombQueryData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure
{
    __block NSMutableArray *pileArray = nil;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ChargePile"];
    bquery.limit = numOfData;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        pileArray = [NSMutableArray array];

        if (error) {
            failure(error);
        } else {
            for (BmobObject *obj in array) {
                QCPileListDataMode *pileData = [[QCPileListDataMode alloc] initWithObject:obj];
                [pileArray addObject:pileData];
            }
            success(pileArray);
        }
    }];
}
+ (void) bombQueryData:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure
{
    __block NSMutableArray *pileArray = nil;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:tableName];
    bquery.limit = numOfData;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        pileArray = [NSMutableArray array];
        
        if (error) {
            failure(error);
        } else {
            for (BmobObject *obj in array) {
                QCPileListDataMode *pileData = [[QCPileListDataMode alloc] initWithObject:obj];
                [pileArray addObject:pileData];
            }
            success(pileArray);
        }
    }];
}
+ (void) bombQueryCPNumber:(NSString *)tableName numOfData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure
{
    __block NSMutableArray *pileArray = nil;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:tableName];
    bquery.limit = numOfData;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        pileArray = [NSMutableArray array];
        
        if (error) {
            failure(error);
        } else {
            for (BmobObject *obj in array) {
                QCPileListNumModel *pileData = [[QCPileListNumModel alloc] initWithObject:obj];
                [pileArray addObject:pileData];;
            }
            success(pileArray);
        }
    }];
}
#else
+ (void) httpQueryCPNumber:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure
{
    // 1.创建请示管理对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager GET:@"http://192.168.1.111:8080/cpserver/getChargePileList" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    [dataTask resume];
}
+ (void) httpQueryCPData:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager GET:@"http://192.168.1.111:8080/cpserver/getChargePileDetail" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    [dataTask resume];
}

+ (void) httpQueryData:(NSString *)URLString params:(NSDictionary *)params success:( void (^)(id json) )success failure:( void (^)(NSError *error) )failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    [dataTask resume];
}
#endif

@end
