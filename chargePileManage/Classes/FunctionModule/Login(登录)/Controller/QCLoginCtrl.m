//
//  QCLoginCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/13.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCLoginCtrl.h"

#import "MBProgressHUD.h"

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

- (instancetype) init {
    self = [super init];
    if (self) {
        WQLog(@"初始化类！");
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WQLog(@"加载view");
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
    WQLog(@"_autoLoginFlg--%i",_autoLoginFlg);
}


- (IBAction)login:(id)sender {
    
    WQLog(@"点击登录按钮！！！");
    
    WQLog(@"用户名:%@",self.userIDText.text);
    WQLog(@"密码:%@",self.pwdText.text);
    
    // 可以保存密码，点击登录后，通过服务器进行帐号验证
    if (self.userIDText.text == nil && self.pwdText.text == nil) {
        // 验证
        WQLog(@"用户名及密码不为空！");
    } else {
        WQLog(@"————————空————————");
        //[MBProgressHUD showError:@"测试showError"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the label text.
        // You can also adjust other label properties if needed.
        // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
            });
        });
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
