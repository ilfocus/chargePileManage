//
//  UIColor+hex.h
//  chargePileManage
//
//  Created by YuMing on 16/6/16.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;
@end
