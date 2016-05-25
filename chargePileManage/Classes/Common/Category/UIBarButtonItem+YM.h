//
//  UIBarButtonItem+YM.h
//  WQWeibo
//
//  Created by YuMing on 15/11/8.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YM)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
