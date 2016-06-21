//
//  QCDataCacheTool.h
//  chargePileManage
//
//  Created by YuMing on 16/6/20.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCDataCacheTool : NSObject
/**
 *  缓存一条数据
 */
+ (void)addChargePileData:(NSDictionary *)dict;
/**
 *  缓存N条数据
 */
+ (void)addChargePileDatas:(NSArray *)dictArray;
@end
