//
//  NSDate+WQ.h
//  WQWeibo
//
//  Created by YuMing on 15/11/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQ)
/**
 *  是否是今天
 *
 *  @return YES OR NO
 */
- (BOOL)isToday;

/**
 *  是否是昨天
 *
 *  @return YES OR NO
 */
- (BOOL)isYesterday;


/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  是否是今年
 *
 *  @return YES OR NO
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差值
 *
 *  @return 时间差
 */
- (NSDateComponents *)deltaWithNow;
@end
