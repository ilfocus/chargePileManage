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

#import "WQItemModel.h"
#import "WQItemArrowModel.h"

@interface QCSysManageCtrl () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *manageView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation QCSysManageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WQColor(226,226,226);
    
    CGFloat headerViewH = 150;
    QCSysManageHeaderView *header = [[QCSysManageHeaderView alloc] init];
    header.frame = CGRectMake(0, 64, SCREEN_WIDTH, headerViewH);
    [self.view addSubview:header];
    
    CGRect tableFrame = CGRectMake(0, headerViewH + 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITableView *manageView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStyleGrouped];
    [self.view addSubview:manageView];
    self.manageView = manageView;
    self.manageView.delegate = self;
    self.manageView.dataSource = self;
    
    [self setupTableView];
    
}

- (void) setupTableView
{
    WQItemModel *clearRecord = [WQItemArrowModel itemWithIcon:@"album" title:@"个人资料"];
    WQItemModel *openSave = [WQItemArrowModel itemWithIcon:@"setting_draft" title:@"我的消息"];
    ///////////////////////////////// 通用设置 /////////////////////////////////////////////////
    WQItemModel *feedBack = [WQItemArrowModel itemWithIcon:@"setting_sndNum" title:@"意见反馈" destVcClass:nil];
    WQItemModel *sotfwareScore = [WQItemArrowModel itemWithIcon:@"setting_sign" title:@"软件评分" destVcClass:nil];
    WQItemModel *useHelp = [WQItemArrowModel itemWithIcon:@"setting_help" title:@"使用帮助" destVcClass:nil];
    WQItemModel *customService = [WQItemArrowModel itemWithIcon:@"setting_answer" title:@"客服帮助" destVcClass:nil];
    WQItemModel *aboutUs = [WQItemArrowModel itemWithIcon:@"setting_copy" title:@"关于我们" destVcClass:nil];
    //////////////////////////////////////////////////////////////////////////////////////////////////

    NSArray *tempArray = @[clearRecord,openSave,feedBack,sotfwareScore,useHelp,customService,aboutUs];
    
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


#pragma mark - gets and sets
- (NSMutableArray *) dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
