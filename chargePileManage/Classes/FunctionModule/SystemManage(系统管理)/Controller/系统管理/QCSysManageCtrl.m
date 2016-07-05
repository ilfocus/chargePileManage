//
//  QCSysManageCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSysManageCtrl.h"

#import "QCSysManageHeaderView.h"
#import "QCSysManageCell.h"
#import "QCPersonalInfoCtrl.h"
#import "QCLoginCtrl.h"
#import "QCFeedBackCtrl.h"

#import "WQItemModel.h"
#import "WQItemArrowModel.h"

@interface QCSysManageCtrl () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,weak) UITableView *manageView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation QCSysManageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WQColor(226,226,226);
    
    CGFloat headerViewH = 100;
    QCSysManageHeaderView *header = [[QCSysManageHeaderView alloc] init];
    header.frame = CGRectMake(0, 64, SCREEN_WIDTH, headerViewH);
    [self.view addSubview:header];
    
    CGFloat tableViewY = headerViewH + 64;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY;
    CGRect tableFrame = CGRectMake(0, tableViewY, SCREEN_WIDTH, tableViewH);
    UITableView *manageView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStyleGrouped];
    manageView.backgroundColor = WQColor(226, 226, 226);
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    manageView.tableHeaderView = headerView;
    [self.view addSubview:manageView];
    self.manageView = manageView;
    self.manageView.delegate = self;
    self.manageView.dataSource = self;
    
    [self setupFooterView:manageView];
    [self setupTableView];
}
/**
 *  jump to login view
 */
- (void) logOut
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void) setupFooterView:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 0, 50);
    view.backgroundColor = WQColor(226, 226, 226);
    tableView.tableFooterView = view;
    
    CGFloat btnW = SCREEN_WIDTH - 20;
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor flatGreenColorDark];
    //[btn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 0, btnW, 40);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [WQColor(226,226,226) CGColor];
    [view addSubview:btn];
    
}

- (void) setupTableView
{
    WQItemModel *personalInfo = [WQItemArrowModel itemWithIcon:@"album" title:@"个人资料" destVcClass:[QCPersonalInfoCtrl class]];
    WQItemModel *myNews = [WQItemArrowModel itemWithIcon:@"setting_draft" title:@"我的消息"];
    ///////////////////////////////// 通用设置 /////////////////////////////////////////////////
    WQItemModel *feedBack = [WQItemArrowModel itemWithIcon:@"setting_sndNum" title:@"意见反馈" destVcClass:[QCFeedBackCtrl class]];
    WQItemModel *sotfwareScore = [WQItemArrowModel itemWithIcon:@"setting_sign" title:@"软件评分" destVcClass:nil];
    WQItemModel *useHelp = [WQItemArrowModel itemWithIcon:@"setting_help" title:@"使用帮助" destVcClass:nil];
    WQItemModel *customService = [WQItemArrowModel itemWithIcon:@"setting_answer" title:@"客服帮助" destVcClass:nil];
    WQItemModel *aboutUs = [WQItemArrowModel itemWithIcon:@"setting_copy" title:@"关于我们" destVcClass:nil];
    //////////////////////////////////////////////////////////////////////////////////////////////////

    NSArray *tempArray = @[personalInfo,myNews,feedBack,sotfwareScore,useHelp,customService,aboutUs];
    
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
    QCSysManageCell *cell = [QCSysManageCell cellWithTableView:tableView];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WQItemModel *item = self.dataArray[indexPath.row];
    
    if (item.option) {
        item.option();
    }  else if ([item isKindOfClass:[WQItemArrowModel class]]) {
        WQItemArrowModel *arrowItem = (WQItemArrowModel *)item;
        // 如果没有需要跳转的控制器
        if (arrowItem.destVcClass == nil) {
            return;
        }
        UIViewController *vc = [[arrowItem.destVcClass alloc]init];
        vc.title = arrowItem.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - AlertViewDelegate
/**
 *  alertView dismiss
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    if (buttonIndex == 1) {
        bool autoLogin = [[accountDefaults objectForKey:UserAutoLoginBoolKey] boolValue];
        if (autoLogin) {
            [accountDefaults setBool:NO forKey:UserAutoLoginBoolKey];
            [accountDefaults synchronize];
        }
        [UIApplication sharedApplication].keyWindow.rootViewController = [[QCLoginCtrl alloc] init];
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
@end
