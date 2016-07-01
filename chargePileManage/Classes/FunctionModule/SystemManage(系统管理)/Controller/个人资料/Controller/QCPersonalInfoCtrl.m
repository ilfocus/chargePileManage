//
//  QCPersonalInfoCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/16.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPersonalInfoCtrl.h"

#import "WQItemModel.h"
#import "WQItemArrowModel.h"
#import "QCItemIconModel.h"
#import "QCItemSegmentModel.h"
#import "WQTableViewGroupModel.h"

#import "QCPersonalInfoCell.h"

#import "QCNickNameAlertCtrl.h"
#import "QCSignatureCtrl.h"
#import "QCChargePwdCtrl.h"

#import "QCDataCacheTool.h"
#import "QCPileListUserModel.h"

#import "QCPersonInfoModel.h"
#import "QCPersonInfoArrowModel.h"
#import "QCPersonInfoLabelModel.h"
#import "QCPersonInfoSwitchModel.h"
#import "QCPersonInfoIconModel.h"
#import "QCPersonInfoSegmentModel.h"


@interface QCPersonalInfoCtrl () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,weak) UITableView *personalInfoView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) QCPileListUserModel *userData;

@property (nonatomic,copy) NSString *subNickName;
@property (nonatomic,copy) NSString *subPermission;
@property (nonatomic,copy) NSString *subAddress;

@end

@implementation QCPersonalInfoCtrl
#pragma mark - init
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat tableViewH = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(0, 0, SCREEN_WIDTH, tableViewH);

    UITableView *personalInfoView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStyleGrouped];
    personalInfoView.backgroundColor = WQColor(226, 226, 226);
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    personalInfoView.tableHeaderView = headerView;
    
    [self.view addSubview:personalInfoView];
    self.personalInfoView = personalInfoView;
    self.personalInfoView.delegate = self;
    self.personalInfoView.dataSource = self;
    
    [self setupView];
    
    [self setupFooterView:personalInfoView];
    
    NSString *dbName = @"chargePileData.sqlite";
    NSString *sqlCmd = @"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT,userID text,passWord text,icon blob,nickName text,sex text,permission text,area text)";
    QCDataCacheTool *cache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:sqlCmd];
    NSArray *arr = [cache getChargePileUser:dbName];
    WQLog(@"---arr---%@",arr);
    if (arr) {
        self.userData = arr[0];
    }
    
    
}
- (void)setupFooterView:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 0, 50);
    view.backgroundColor = WQColor(226, 226, 226);
    tableView.tableFooterView = view;
    
    CGFloat btnW = SCREEN_WIDTH - 20;
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor flatGreenColorDark];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(savePersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 0, btnW, 40);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [WQColor(226,226,226) CGColor];
    [view addSubview:btn];
    
}
- (void)savePersonalInfo
{
    WQLog(@"保存！！！");
}
- (void)setupView
{
    QCPersonInfoModel *icon = [QCPersonInfoIconModel itemWithTitle:@"头像"];
    
    QCPersonInfoModel *nickName = [QCPersonInfoArrowModel itemWithTitle:@"昵称" subTitle:@"输入昵称" destVcClass:[QCNickNameAlertCtrl class]];
    QCPersonInfoModel *sex = [QCPersonInfoSegmentModel itemWithTitle:@"性别"];
    QCPersonInfoModel *changePwd = [QCPersonInfoArrowModel itemWithTitle:@"修改密码" destVcClass:[QCChargePwdCtrl class]];
    QCPersonInfoModel *accountPermission = [QCPersonInfoArrowModel itemWithTitle:@"帐号权限" subTitle:@"系统用户" destVcClass:nil];
    QCPersonInfoModel *address = [QCPersonInfoArrowModel itemWithTitle:@"所在小区" subTitle:@"星晓家园" destVcClass:nil];

    NSArray *tempArray = @[icon,nickName,sex,changePwd,accountPermission,address];
    self.dataArray = (NSMutableArray *)tempArray;
}
#pragma mark - UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCPersonalInfoCell *cell = [QCPersonalInfoCell cellWithTableView:tableView];
    QCPersonInfoModel *item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCPersonInfoModel *item = self.dataArray[indexPath.row];
    
    if ([item.title isEqualToString:@"头像"]) {
        return 65;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QCPersonInfoModel *item = self.dataArray[indexPath.row];
    
    if (item.option) {
        item.option();
    }  else if ([item isKindOfClass:[QCPersonInfoArrowModel class]]) {
        QCPersonInfoArrowModel *arrowItem = (QCPersonInfoArrowModel *)item;
        // 如果没有需要跳转的控制器
        if (arrowItem.destVcClass == nil) {
            return;
        }
        
        if (arrowItem.destVcClass == [QCNickNameAlertCtrl class]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入昵称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            alert.tag = 0;
            UITextField *text = [alert textFieldAtIndex:0];
            text.text = item.subTitle;
            
            [alert show];
            return;
        }
        
        if (arrowItem.destVcClass == [QCSignatureCtrl class]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入个性签名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            alert.tag = 1;
            UITextField *text = [alert textFieldAtIndex:0];
            text.text = item.subTitle;
            
            [alert show];
            return;
        }
        
        UIViewController *vc = [[arrowItem.destVcClass alloc]init];
        vc.title = arrowItem.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UITextField *text = [alertView textFieldAtIndex:0];
    
    if (buttonIndex == 0) {
        WQLog(@"点击取消");
    } else {
        
        if (alertView.tag == 0) {
            for (QCPersonInfoModel *item in self.dataArray) {
                if ([item.title isEqualToString:@"昵称"]) {
                    item.subTitle = text.text;
                    [_personalInfoView reloadData];
                    break;
                }
            }
        }
        if (alertView.tag == 1) {
            for (QCPersonInfoModel *item in self.dataArray) {
                if ([item.title isEqualToString:@"个性签名"]) {
                    item.subTitle = text.text;
                    [_personalInfoView reloadData];
                    break;
                }
            }
        }
        WQLog(@"alertView---%@",text.text);
    }
    
}
#pragma mark - gets and sets
- (NSMutableArray *) dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setUserData:(QCPileListUserModel *)userData
{
    if (_userData != userData) {
        _userData = userData;
        
        for (QCPersonInfoModel *user in self.dataArray) {
            if ([user.title isEqualToString:@"昵称"]) {
                user.subTitle = userData.nickName;
            }
        }
    }
    [self.personalInfoView reloadData];
}
@end
