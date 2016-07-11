//
//  QCChooseRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/7/8.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChooseRecordCtrl.h"
#import "QCSearchREcordModel.h"

@interface QCChooseRecordCtrl () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *chargeRecordBtn;
@property (weak, nonatomic) IBOutlet UITextField *checkWord;
- (IBAction)searchRecord;
@property (weak, nonatomic) IBOutlet UIButton *supplyRecordBtn;

@property (nonatomic,strong) QCSearchRecordModel *searchModel;
@end

@implementation QCChooseRecordCtrl
#pragma - mark systemViewEvent
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WQColor(226,226,226);
    [self setupView];
}
- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}
#pragma - mark keyBoardEvent
- (void) keyBoardDidShow:(NSNotification *)notification
{
    WQLog(@"键盘出现！！！");
    // 获得键盘尺寸
    NSDictionary *info = notification.userInfo;
    NSValue *aValue = [info objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGSize keyBoardSize = [aValue CGRectValue].size;
    // 重新定义ScrollView的尺寸
    CGRect scrollViewFrame = self.scrollView.frame;
//    scrollViewFrame.size.height -= (keyBoardSize.height - 30);
//    self.scrollView.frame = scrollViewFrame;
    self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + keyBoardSize.height);
    
//    self.scrollView.contentOffset += keyBoardSize.height;
    
    [self.scrollView setContentOffset:CGPointMake(0, 110)];
    
    // 获取当前文本框架大小
    CGRect textFieldRect = [self.checkWord frame];
    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];
}
- (void) keyBoardDidHide:(NSNotification *) notif
{
    //当键盘隐藏的时候，将scrollView重新放下来
    CGRect scrollViewFrame = self.scrollView.frame;
    self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + 30);
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
}
#pragma - mark initUI
- (void) setupView
{
    [_chargeRecordBtn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [_chargeRecordBtn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    _checkWord.delegate = self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_checkWord endEditing:YES];
}
#pragma - mark UITextFileDelegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
//    WQLog(@"开始编辑！！！");

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    WQLog(@"点击确定按钮！！！");
    [_checkWord resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchRecord {
    WQLog(@"%s",__func__);
    
    // 按下按键后，通知代理
    if ([self.delegate respondsToSelector:@selector(searchRecord:)]) {
        // 给每个按钮绑定一个tag，这样才能知道从哪个按钮跳到哪个按钮
        // 按键按下时候，调用代理方法
        self.searchModel.searchType = @"充电记录";
        self.searchModel.beginTime = @"20160711";
        self.searchModel.endTime = @"20160712";
        if (_checkWord.text) {
            self.searchModel.searchWord = _checkWord.text;
        } else {
            self.searchModel.searchWord = @"";
        }
        [self.delegate searchRecord:self.searchModel];
    }
    // 让控制器成为WQTabBar代理，就可以监控WQTabBar的动作了
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma - mark sets and gets
- (QCSearchRecordModel *)searchModel
{
    if (_searchModel == nil) {
        _searchModel = [QCSearchRecordModel new];
    }
    return _searchModel;
}

@end
