//
//  QCReminderUser.h
//  chargePileManage
//
//  Created by YuMing on 16/6/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCReminderUserTool : NSObject
+ (void) showCorrect:(UIView *)view str:(NSString *)str;
+ (void) showError:(UIView *)view str:(NSString *)str;
+ (void) showLoad:(UIView *)view;
@end
