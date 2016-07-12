//
//  QCChooseRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/7/8.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChooseRecordCtrl.h"
#import "QCSearchREcordModel.h"
#import "UUDatePicker.h"

@interface QCChooseRecordCtrl () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *chargeRecordBtn;
@property (weak, nonatomic) IBOutlet UIButton *supplyRecordBtn;
- (IBAction)chargeRecord;
- (IBAction)supplyRecord;
@property (weak, nonatomic) IBOutlet UITextField *checkWord;
- (IBAction)searchRecord;
@property (weak, nonatomic) IBOutlet UITextField *beginTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeField;

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
    
    // 获得键盘尺寸
//    NSDictionary *info = notification.userInfo;
//    NSValue *aValue = [info objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyBoardSize = [aValue CGRectValue].size;
//    // 重新定义ScrollView的尺寸
//    if (keyBoardSize.height == 200) {
//        return;
//    }
//    CGRect scrollViewFrame = self.scrollView.frame;
//    self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + keyBoardSize.height);
//    [self.scrollView setContentOffset:CGPointMake(0, 90)];
}
- (void) keyBoardDidHide:(NSNotification *) notif
{
    //当键盘隐藏的时候，将scrollView重新放下来
    CGRect scrollViewFrame = self.scrollView.frame;
    self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + 30);
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
}
#pragma - mark initUI
- (void) setupBtnBackGroud:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor flatBlackColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [WQColor(226,226,226) CGColor];
}
- (void) setupView
{
    [self setupBtnBackGroud:_chargeRecordBtn];
    [self setupBtnBackGroud:_supplyRecordBtn];
    
    
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    _beginTimeField.text = locationString;
    _endTimeField.text = locationString;
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *modelStr=[dateformatter stringFromDate:senddate];
    self.searchModel.searchType = @"充电记录";
    self.searchModel.beginTime = modelStr;
    self.searchModel.endTime = modelStr;

    
    UUDatePicker *beginDatePicker = [[UUDatePicker alloc] initWithframe:CGRectMake(0, 0, 320, 200)
                                                       PickerStyle:UUDateStyle_YearMonthDay
                                                       didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
                                                           NSLog(@"%@年%@月%@日",year,month,day);
                                                           _beginTimeField.text = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
                                                           self.searchModel.beginTime = [NSString stringWithFormat:@"%@%@%@",year,month,day];
                                                       }];
    _beginTimeField.inputView   = beginDatePicker;
    
    UUDatePicker *endDatePicker = [[UUDatePicker alloc] initWithframe:CGRectMake(0, 0, 320, 200)
                                                            PickerStyle:UUDateStyle_YearMonthDay
                                                            didSelected:^(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
                                                                NSLog(@"%@年%@月%@日",year,month,day);
                                                                _endTimeField.text = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
                                                                self.searchModel.endTime = [NSString stringWithFormat:@"%@%@%@",year,month,day];
                                                            }];
    _endTimeField.inputView     = endDatePicker;
    
    _beginTimeField.delegate = self;
    _endTimeField.delegate = self;
    _checkWord.delegate = self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma - mark UITextFileDelegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    WQLog(@"开始编辑！！！");
    
    if (textField == _beginTimeField) {
        WQLog(@"_beginTimeField");
        CGRect scrollViewFrame = self.scrollView.frame;
        self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + 200);
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    } else if (textField == _endTimeField) {
        WQLog(@"_endTiemField");
        CGRect scrollViewFrame = self.scrollView.frame;
        self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + 200);
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    } else {
        WQLog(@"_checkWord");
        CGRect scrollViewFrame = self.scrollView.frame;
        self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width, scrollViewFrame.size.height + 253);
        [self.scrollView setContentOffset:CGPointMake(0, 150)];
    }
    
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
#pragma - mark BTN_FUN
- (IBAction)searchRecord {
    WQLog(@"%s",__func__);
    
    self.searchModel.searchWord = _checkWord.text;
    // 按下按键后，通知代理
    if ([self.delegate respondsToSelector:@selector(searchRecord:)]) {
        // 给每个按钮绑定一个tag，这样才能知道从哪个按钮跳到哪个按钮
        // 按键按下时候，调用代理方法
//        self.searchModel.searchType = @"充电记录";
//        self.searchModel.beginTime = @"20160711";
//        self.searchModel.endTime = @"20160712";
        
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

- (IBAction)chargeRecord {
    WQLog(@"%s",__func__);
    _chargeRecordBtn.backgroundColor = [UIColor flatGreenColor];
    _supplyRecordBtn.backgroundColor = [UIColor clearColor];
    [_chargeRecordBtn setTitleColor:[UIColor flatGreenColor] forState:UIControlStateNormal];
    [_supplyRecordBtn setTitleColor:[UIColor flatBlackColor] forState:UIControlStateNormal];
    self.searchModel.searchType = @"充电记录";
}

- (IBAction)supplyRecord {
    
    WQLog(@"%s",__func__);
    _chargeRecordBtn.backgroundColor = [UIColor clearColor];
    _supplyRecordBtn.backgroundColor = [UIColor flatGreenColor];
    [_chargeRecordBtn setTitleColor:[UIColor flatBlackColor] forState:UIControlStateNormal];
    [_supplyRecordBtn setTitleColor:[UIColor flatGreenColor] forState:UIControlStateNormal];
    self.searchModel.searchType = @"供电记录";
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
