//
//  WQTableViewItemsModel.h
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WQItemOption)();

@interface WQItemModel : NSObject
/**
 *  图标
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic,copy) NSString *subTitle;
/**
 *  总费用
 */
@property (nonatomic,assign) float costValue;
/**
 * 点击cell需要完成的事，block来实现
 */
@property (nonatomic,copy) WQItemOption option;
/**
 *  item设置图标及标题、子标题
 */
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
/**
 *  item设置图标及文字
 */
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
/**
 *  item上只设置文字
 */
+ (instancetype)itemWithTitle:(NSString *)title;
@end
