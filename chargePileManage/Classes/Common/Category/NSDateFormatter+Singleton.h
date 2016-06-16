//
//  NSDateFormatter+Singleton.h
//  iosapp
//
//  Created by AeternChan on 10/15/15.
//  Copyright © 2015 oschina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Singleton)

+ (instancetype)sharedInstance;

@end
