//
//  QCChooseRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/7/8.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChooseRecordCtrl.h"

@interface QCChooseRecordCtrl ()
@property (weak, nonatomic) IBOutlet UIButton *chargeRecordBtn;
@property (weak, nonatomic) IBOutlet UIButton *supplyRecordBtn;
@end

@implementation QCChooseRecordCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = WQColor(226,226,226);
    [self setupView];
    
}
#pragma - mark initUI
- (void) setupView
{
    [_chargeRecordBtn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [_chargeRecordBtn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
