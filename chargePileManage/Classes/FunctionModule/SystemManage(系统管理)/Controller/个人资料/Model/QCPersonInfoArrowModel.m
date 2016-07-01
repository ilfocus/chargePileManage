//
//  QCPersonInfoArrowModel.m
//  chargePileManage
//
//  Created by YuMing on 16/7/1.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPersonInfoArrowModel.h"

@implementation QCPersonInfoArrowModel

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    QCPersonInfoArrowModel *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    QCPersonInfoArrowModel *item = [self itemWithIcon:icon title:title];
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
