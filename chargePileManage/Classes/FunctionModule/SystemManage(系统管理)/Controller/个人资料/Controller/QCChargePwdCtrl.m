//
//  QCChargePwdCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/17.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargePwdCtrl.h"

@interface QCChargePwdCtrl () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *creatPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
- (IBAction)savePwd:(id)sender;
@property (nonatomic,weak) UIImageView *bgImage;
@end

@implementation QCChargePwdCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = WQColor(226,226,226);
    _oldPwd.delegate = self;
    _creatPwd.delegate = self;
    _confirmPwd.delegate = self;
    
    _topView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)savePwd:(id)sender {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _oldPwd) {
        [_oldPwd resignFirstResponder];
    }
    if (textField == _creatPwd) {
        [_creatPwd resignFirstResponder];
    }
    if (textField == _confirmPwd) {
        [_confirmPwd resignFirstResponder];
    }
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![_oldPwd isExclusiveTouch]) {
        [_oldPwd resignFirstResponder];
    }
    if (![_creatPwd isExclusiveTouch]) {
        [_creatPwd resignFirstResponder];
    }
    if (![_confirmPwd isExclusiveTouch]) {
        [_confirmPwd resignFirstResponder];
    }
}
@end
