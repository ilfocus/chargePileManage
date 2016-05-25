//
//  UIBarButtonItem+YM.m
//  WQWeibo
//
//  Created by YuMing on 15/11/8.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIBarButtonItem+YM.h"

@implementation UIBarButtonItem (YM)


/**
 *  快速创建一个显示图片的item
 *
 *  @param icon     正常图片
 *  @param highIcon 高亮图片
 *  @param action   点击执行方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithNamed:highIcon] forState:UIControlStateHighlighted];
    btn.frame = (CGRect){CGPointZero,btn.currentBackgroundImage.size};
    // 监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
