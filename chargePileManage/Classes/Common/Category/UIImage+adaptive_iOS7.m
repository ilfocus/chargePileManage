//
//  UIImage+adaptive_iOS7.m
//  WQWeibo
//
//  Created by YuMing on 15/11/5.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIImage+adaptive_iOS7.h"

@implementation UIImage (adaptive_iOS7)

+(UIImage *)imageWithNamed:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


@end
