//
//  NSString+ChineseChar.m
//  MessageGroups
//
//  Created by YuMing on 16/3/15.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import "NSString+ChineseChar.h"

@implementation NSString (ChineseChar)
+ (BOOL)isChinese:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
    
    for (int i = 0; i < [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}
@end
