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
#import "QCDataCacheTool.h"
#import "QCPileListUserModel.h"
#import "QCHttpTool.h"
// thrid lib
#import "MBProgressHUD.h"


@interface QCLoginCtrl () <UITextFieldDelegate>

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

NSString *const UserRememberBoolKey     = @"rememberPwd";
NSString *const UserAutoLoginBoolKey    = @"autoLogin";
NSString *const userNameStrKey          = @"userName";
NSString *const userPwdStrKey           = @"userPwd";
NSString *const userKindStrKey           = @"userkind";


- (void)viewDidLoad {
    [super viewDidLoad];
    _userIDText.delegate = self;
    _pwdText.delegate    = self;
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
        [UIApplication sharedApplication].keyWindow.rootViewController = [[QCTabBarController alloc]init];
    }
}

- (IBAction)login:(id)sender {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[QCTabBarController alloc]init];
    // save password,through the server for account validation
    if ([self.userIDText.text isNotBlank] && [self.pwdText.text isNotBlank]) { // 帐号密码都不为空
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"登录中...", @"HUD loading title");
        [hud show:YES];
        
        
        // account password sent to the server for validation
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"loginid"] = self.userIDText.text;
        params[@"passwd"] = self.pwdText.text;
        NSString *ulrString = [NSString stringWithFormat:@"%@%@",CPMAPI_PREFIX,CPMAPI_USER_LOGIN];
        
        
        [QCHttpTool httpQueryData:ulrString params:params success:^(id json) {
            NSString *errorCode = json[@"errorCode"];
            WQLog(@"---json---%@",json);
            if (![errorCode isNotBlank]) {
                [hud hide:YES];
                [self saveUserInfo:json];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[QCTabBarController alloc]init];
            } else {
                [hud hide:YES];
                [QCReminderUserTool showError:self.view str:@"用户名或密码错误"];
            }
        } failure:^(NSError *error) {
            [QCReminderUserTool showError:self.view str:@"加载错误"];
            [hud hide:YES];
        }];
    } else {
        if (![self.userIDText.text isNotBlank]) {
            [QCReminderUserTool showError:self.view str:@"用户名不能为空"];
        } else if (![self.pwdText.text isNotBlank]) {
            [QCReminderUserTool showError:self.view str:@"密码不能为空"];
        }
        
    }
    
}

- (void) saveUserInfo:(id)json
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    // after the success of validation,store the data in the database
    NSString *dbName = @"chargePileData.sqlite";
    NSString *sqlCmd = @"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT,userID text,passWord text,icon blob,nickName text,sex text,permission text,area text)";
    QCDataCacheTool *cache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:sqlCmd];
    
    NSArray *arr = [cache getChargePileUser:dbName]; // get userID in the database
    
    NSArray *userArr = json[@"detail"];
    for (NSDictionary *dict in userArr) {
        WQLog(@"---userName---%@",dict[@"username"]);
        WQLog(@"---userKind---%@",dict[@"userkind"]);
        
        [accountDefaults setObject:dict[@"username"] forKey:userNameStrKey];
        [accountDefaults setObject:dict[@"userkind"] forKey:userKindStrKey];
    }
    
    //  set model data
    QCPileListUserModel *userData = [[QCPileListUserModel alloc] init];
    userData.userID = [accountDefaults objectForKey:userNameStrKey];
    userData.passWord = [accountDefaults objectForKey:userPwdStrKey];
    userData.icon = [UIImage imageNamed:@"icon"];
    userData.nickName = @"小小鸟er";
    userData.sex = @"男";
    
    int userRight = [[accountDefaults objectForKey:userKindStrKey] intValue];
    switch (userRight) {
        case 1: {
            userData.permission = @"超级管理员";
            break;
        }
        case 2: {
            userData.permission = @"普通管理员";
            break;
        }
        case 3: {
            userData.permission = @"普通用户";
            break;
        }
        default: {
            userData.permission = @"普通用户";
            break;
        }
    }
    
    userData.area = @"上海市";
    
    // save model data
    if (arr.count == 0) {
        [cache addChargePileUser:dbName cpData:userData];
    } else {
        bool userFlg = NO;
        for (QCPileListUserModel *user in arr) {
            if ([userData.userID isEqualToString:user.userID]) {
                userFlg = YES;
            }
        }
        if (userFlg == NO) {
            [cache addChargePileUser:dbName cpData:userData];
        }
    }
    [QCReminderUserTool showLoad:self.view];
    
    if (_rememberPwdFlg) {  // 登录时，如果有选中记住密码，则记住
        if (self.userIDText.text && self.pwdText.text) {
            [accountDefaults setObject:self.userIDText.text forKey:userNameStrKey];
            [accountDefaults setObject:self.pwdText.text forKey:userPwdStrKey];
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

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userIDText) {
        WQLog(@"用户完成");
        [_userIDText resignFirstResponder];
    }
    if (textField == _pwdText) {
        WQLog(@"密码完成");
        [_pwdText resignFirstResponder];
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![_userIDText isExclusiveTouch]) {
        [_userIDText resignFirstResponder];
    }
    if (![_pwdText isExclusiveTouch]) {
        [_pwdText resignFirstResponder];
    }
}

@end
