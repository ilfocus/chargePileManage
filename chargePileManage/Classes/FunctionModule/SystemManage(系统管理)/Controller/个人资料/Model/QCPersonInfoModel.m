//
//  QCPersonalInfoModel.m
//  chargePileManage
//
//  Created by YuMing on 16/7/1.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPersonInfoModel.h"

@implementation QCPersonInfoModel

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle
{
    QCPersonInfoModel *item = [self new];
    item.icon = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    return [self itemWithIcon:icon title:title subTitle:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
