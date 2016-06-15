//
//  QCReminderUser.m
//  chargePileManage
//
//  Created by YuMing on 16/6/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCReminderUserTool.h"
#import "MBProgressHUD.h"

static const CGFloat QCDuration = 1.0;
@implementation QCReminderUserTool
+ (void) showCorrect:(UIView *)view str:(NSString *)str
{
    [QCReminderUserTool showMessage:view str:str state:YES];
}
+ (void) showError:(UIView *)view str:(NSString *)str
{
    [QCReminderUserTool showMessage:view str:str state:NO];
}

+ (void) showMessage:(UIView *)view str:(NSString *)str state:(bool)flg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    if (flg) {
        UIImage *image = [[UIImage imageNamed:@"Correct"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
    } else {
        UIImage *image = [[UIImage imageNamed:@"Error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }
    hud.square = YES;
    hud.labelText = str;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}

+ (void) showLoad:(UIView *)view str:(NSString *)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the label text.
    hud.labelText = str;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}
+ (void) showLoad:(UIView *)view
{
    [QCReminderUserTool showLoad:view str:NSLocalizedString(@"Loading...", @"HUD loading title")];
}
@end
