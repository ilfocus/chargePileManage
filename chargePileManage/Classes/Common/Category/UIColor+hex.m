//
//  UIColor+hex.m
//  chargePileManage
//
//  Created by YuMing on 16/6/16.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "UIColor+hex.h"

@implementation UIColor (hex)
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}
@end
