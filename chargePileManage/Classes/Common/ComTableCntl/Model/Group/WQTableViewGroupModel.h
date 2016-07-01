//
//  WQTableViewGroupModel.h
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQTableViewGroupModel : NSObject
/**
 *  组的头部标题
 */
@property (nonatomic,copy) NSString *header;
/**
 *  组的尾部标题
 */
@property (nonatomic,copy) NSString *footer;
/**
 *  存放着items模型，也就是一组数组中总的行数据数
 */
@property (nonatomic,copy) NSArray *items;
@end
