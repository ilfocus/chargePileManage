//
//  WQTableViewItemsModel.m
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import "WQItemModel.h"

@implementation WQItemModel
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle
{
    WQItemModel *item = [self new];
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
