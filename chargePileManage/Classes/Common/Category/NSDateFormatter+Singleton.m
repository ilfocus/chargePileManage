//
//  NSDateFormatter+Singleton.m
//  iosapp
//
//  Created by AeternChan on 10/15/15.
//  Copyright © 2015 oschina. All rights reserved.
//

#import "NSDateFormatter+Singleton.h"

@implementation NSDateFormatter (Singleton)

+ (instancetype)sharedInstance
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    
    return formatter;
}

@end
