//
//  UIImage+adaptive_iOS7.h
//  WQWeibo
//
//  Created by YuMing on 15/11/5.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (adaptive_iOS7)

+ (UIImage *)imageWithNamed:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
