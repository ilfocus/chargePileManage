//
//  UIView+Round.m
//  chargePileManage
//
//  Created by YuMing on 16/6/2.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "UIView+Round.h"

@implementation UIView (Round)
- (instancetype)initWithRoundRect:(CGRect)rect
{
    
    self = [self init];
    self.frame = rect;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = MIN(rect.size.width, rect.size.height) / 2;
//    self.layer.borderWidth = 1.0;
//    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.backgroundColor = [UIColor greenColor];
    return self;
}
- (instancetype)initWithRoundRect:(CGRect)rect backColor:(UIColor *)color
{
    self = [self initWithRoundRect:rect];
    self.backgroundColor = color;
    return self;
}
@end
