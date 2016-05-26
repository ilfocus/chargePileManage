//
//  WQItemArrowModel.m
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import "WQItemArrowModel.h"

@implementation WQItemArrowModel
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    WQItemArrowModel *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    WQItemArrowModel *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    item.subTitle = subTitle;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title subTitle:subTitle destVcClass:destVcClass];
}
@end
