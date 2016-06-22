//
//  QCDataCacheTool.h
//  chargePileManage
//
//  Created by YuMing on 16/6/20.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QCPileListNumModel;
@class QCPileListDataMode;
@interface QCDataCacheTool : NSObject
/**
 *  缓存一条数据
 */
- (void)addChargePileData:(NSString *)dbName sqlCmd:(NSString *)sqlCmd dict:(NSDictionary *)dict;
+ (void) addChargePileData:(NSDictionary *) dict;
// 保存多条充电桩号码模型数据
- (void)addChargePileDatas:(NSString *)dbName sqlCmd:(NSString *)sqlCmd cpNumArray:(NSArray *)cpArray;
/**
 *  缓存N条数据
 */
- (void)addChargePileDatas:(NSString *)dbName sqlCmd:(NSString *)sqlCmd array:(NSArray *)dictArray;
+ (void)addChargePileDatas:(NSArray *)dictArray;
// 保存一条充电桩号码模型数据
- (void)addChargePileData:(NSString *)dbName sqlCmd:(NSString *)sqlCmd chargeNum:(QCPileListNumModel *)number;
- (void)addChargePileData:(NSString *)dbName sqlData:(NSString *)sqlCmd cpData:(QCPileListDataMode *)data;

/**
 *  初始化
 */
- (instancetype) initWithDBName:(NSString *)dbName sqlCmd:(NSString *)sqlCmd;

/**
 *  读取数据
 */
- (NSArray *)cpDataWithParam:(NSString *)dbName;
@end
