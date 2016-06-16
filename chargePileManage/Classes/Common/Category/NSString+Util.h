//
//  NSString+Util.h
//  iosapp
//
//  Created by AeternChan on 10/16/15.
//  Copyright © 2015 oschina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (NSString *)escapeHTML;
- (NSString *)deleteHTMLTag;

@end
