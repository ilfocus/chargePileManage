//
//  QCFeedBackCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/20.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCFeedBackCtrl.h"

@interface QCFeedBackCtrl ()
@property (weak, nonatomic) IBOutlet UITextField *feedBackText;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end

@implementation QCFeedBackCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = WQColor(226,226,226);
    
    _feedBackText.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
