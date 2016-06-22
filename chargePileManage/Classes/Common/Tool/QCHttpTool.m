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

@implementation QCHttpTool

//+ (void) bombQueryData:(NSInteger) numOfData success:(void (^)(NSArray *arr))success failure:(void (^)(NSError *error))failure
//{
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ChargePile"];
//    bquery.limit = numOfData;
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        if (error) {
//            failure(error);
//        } else {
//            success(array);
//        }
//    }];
//}
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
                [pileArray addObject:pileData];
//                NSString *chargePileNum = [obj objectForKey:@"ChargePileAddress"];
//                WQLog(@"BmobObject---%@",chargePileNum);
            }
            success(pileArray);
        }
    }];
}
@end
