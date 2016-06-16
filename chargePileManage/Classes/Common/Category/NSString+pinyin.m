//
//  NSString+pinyin.m
//  iosapp
//
//  Created by 王晨 on 15/8/25.
//  Copyright © 2015年 oschina. All rights reserved.
//

#import "NSString+pinyin.h"

@implementation NSString (pinyin)
/*
- (NSString*)pinyinFirst{
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:[self substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    return result;
}
*/
- (NSString*)pinyin {
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)result,NULL, kCFStringTransformStripDiacritics,NO);
    return [result uppercaseString];
}
@end
