//
//  NSArray+SortAndDistinct.m
//  chargePileManage
//
//  Created by YuMing on 16/6/23.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "NSArray+SortAndDistinct.h"

@implementation NSArray (SortAndDistinct)
+ (NSArray *) numStrArraySortAndDistinct:(NSArray *)arr
{
    if (arr == nil) {
        return nil;
    }
    // 参数检查,arr数组内必须是字符串数据
    BOOL (^checkArray)(NSArray *)  = ^(NSArray *array) {
        
        for (id str in array) {
            if (![str isKindOfClass:[NSString class]]) {
                return NO;
            }
            
            NSScanner* scan = [NSScanner scannerWithString:str];
            
            int val;
            
            if (!(BOOL)([scan scanInt:&val] && [scan isAtEnd])) {
                return NO;
            }
        }
        
        return YES;
    };
    if (!checkArray(arr)) {
        return nil;
    }
    /**
     *  去重
     */
    NSSet *pileNumberSet = [NSSet setWithArray:arr];
    /**
     *  排序
     */
    NSArray *tempArray = [pileNumberSet allObjects];
    
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    };
    //数组排序：
    return [tempArray sortedArrayUsingComparator:finderSort];
}
@end
