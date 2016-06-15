//
//  QCLoginCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/13.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCLoginCtrl.h"
#import "QCTabBarController.h"
#import "QCReminderUserTool.h"

#import "YYKit.h"



@interface QCLoginCtrl ()
@property (weak, nonatomic) IBOutlet UITextField *userIDText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UIButton *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwd;
@property (nonatomic,assign) bool rememberPwdFlg;
@property (nonatomic,assign) bool autoLoginFlg;

- (IBAction)login:(id)sender;
- (IBAction)autoLogin:(id)sender;
- (IBAction)rememberPwd:(id)sender;

@end

@implementation QCLoginCtrl

NSString *const UserRememberBoolKey = @"rememberPwd";
NSString *const UserAutoLoginBoolKey = @"autoLogin";
NSString *const userNameStrKey = @"userName";
NSString *const userPwdStrKey = @"userPwd";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupView];
}

- (void) setupView
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    _rememberPwdFlg = [[accountDefaults objectForKey:UserRememberBoolKey] boolValue];
    if (_rememberPwdFlg) {
        [self.rememberPwd setImage:[UIImage imageNamed:@"photo_state_selected" ] forState:UIControlStateNormal];
        self.userIDText.text = [accountDefaults objectForKey:userNameStrKey];
        self.pwdText.text = [accountDefaults objectForKey:userPwdStrKey];
        
    } else {
        [self.rememberPwd setImage:[UIImage imageNamed:@"photo_state_normal" ] forState:UIControlStateNormal];
    }
    _autoLoginFlg = [[accountDefaults objectForKey:UserAutoLoginBoolKey] boolValue];
    if (_autoLoginFlg) {
        [self.autoLogin setImage:[UIImage imageNamed:@"photo_state_selected" ] forState:UIControlStateNormal];
    } else {
        [self.autoLogin setImage:[UIImage imageNamed:@"photo_state_normal" ] forState:UIControlStateNormal];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    if (_autoLoginFlg) {
        // 在这里添加登录效果
        [UIApplication sharedApplication].keyWindow.rootViewController = [[QCTabBarController alloc]init];
    }
}

- (IBAction)login:(id)sender {
    
    // 可以保存密码，点击登录后，通过服务器进行帐号验证
    if ([self.userIDText.text isNotBlank] && [self.pwdText.text isNotBlank]) {
        // 验证
        if ([self.userIDText.text isEqualToString:@"wangqi"] && [self.pwdText.text isEqualToString:@"123456"]) {
            //[QCReminderUserTool showCorrect:self.view str:@"输入帐号正确"];
            [QCReminderUserTool showLoad:self.view];
            //sleep(3.0);
            [UIApplication sharedApplication].keyWindow.rootViewController = [[QCTabBarController alloc]init];
        } else {
            if (![self.userIDText.text isEqualToString:@"wangqi"]) {
                [QCReminderUserTool showError:self.view str:@"用户名不存在"];
            } else if (![self.pwdText.text isEqualToString:@"123456"]) {
                [QCReminderUserTool showError:self.view str:@"密码不正确"];
            }
            
        }
    } else {
        if (![self.userIDText.text isNotBlank]) {
            [QCReminderUserTool showError:self.view str:@"用户名不能为空"];
        } else if (![self.pwdText.text isNotBlank]) {
            [QCReminderUserTool showError:self.view str:@"密码不能为空"];
        }
    }
    
}

- (IBAction)rememberPwd:(id)sender {
    _rememberPwdFlg = !_rememberPwdFlg;
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    if (_rememberPwdFlg) {
        [self.rememberPwd setImage:[UIImage imageNamed:@"photo_state_selected" ] forState:UIControlStateNormal];
        
        if (self.userIDText.text && self.pwdText.text) {
            [accountDefaults setObject:self.userIDText.text forKey:userNameStrKey];
            [accountDefaults setObject:self.pwdText.text forKey:userPwdStrKey];
        }
        
    } else {
        [self.rememberPwd setImage:[UIImage imageNamed:@"photo_state_normal" ] forState:UIControlStateNormal];
    }
    
    
    [accountDefaults setBool:_rememberPwdFlg forKey:UserRememberBoolKey];
    [accountDefaults synchronize];
}
- (IBAction)autoLogin:(id)sender {
    _autoLoginFlg = !_autoLoginFlg;
    
    if (_autoLoginFlg) {
        [self.autoLogin setImage:[UIImage imageNamed:@"photo_state_selected" ] forState:UIControlStateNormal];
    } else {
        [self.autoLogin setImage:[UIImage imageNamed:@"photo_state_normal" ] forState:UIControlStateNormal];
    }
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setBool:_autoLoginFlg forKey:UserAutoLoginBoolKey];
    [accountDefaults synchronize];
}
@end
