//
//  QCPersonalInfoModel.h
//  chargePileManage
//
//  Created by YuMing on 16/7/1.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^WQItemOption)();

@interface QCPersonInfoModel : NSObject
/**
 *  图标
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  头像
 */
@property (nonatomic,strong) UIImage *image;
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
 *  充电桩ID
 */
@property (nonatomic,copy) NSString *cpid;
/**
 *  性别
 */
@property (nonatomic,assign) int gender;
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
