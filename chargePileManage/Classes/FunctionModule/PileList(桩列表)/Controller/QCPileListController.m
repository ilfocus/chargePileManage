//
//  QCPileListController.m
//  chargePileManage
//
//  Created by YuMing on 16/5/25.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListController.h"

#import "WQItemModel.h"
#import "WQItemArrowModel.h"
#import "WQTableViewGroupModel.h"
//#import "WQBaseCell.h"

#import "QCPileListCell.h"
#import "QCPileListCellModel.h"
#import "QCPileListDetailCtrl.h"

//#import "MJExtension.h"
#import "MJRefresh.h"
#import "QCChiBaoZiHeader.h"

static const CGFloat QCDuration = 2.0;

@interface QCPileListController ()
//@property (nonatomic, strong) NSMutableArray *pileListCellDatas;
@end

@implementation QCPileListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGroup0];
    
    self.tableView.rowHeight = PileListCellHeight;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    QCChiBaoZiHeader *header = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView = headerView;
}
- (void)loadNewData
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.data insertObject:MJRandomData atIndex:0];
//    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}
/**
 * 设置第0组样式
 */
- (void)setGroup0
{
    ///////////////////////////////// 有设置目标控制器 /////////////////////////////////////////////////
    WQItemModel *everyMsgNumber = [QCPileListCellModel itemWithIcon:@"setting_sndNum" title:@"0001#充电桩" subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *setMsgContent = [QCPileListCellModel itemWithIcon:@"setting_sign" title:@"0002#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *useHelp = [QCPileListCellModel itemWithIcon:@"setting_help" title:@"0003#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *comQuestion = [QCPileListCellModel itemWithIcon:@"setting_answer" title:@"0004#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    
    WQItemModel *everyMsgNumber1 = [QCPileListCellModel itemWithIcon:@"setting_sndNum" title:@"0005#充电桩" subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *setMsgContent1 = [QCPileListCellModel itemWithIcon:@"setting_sign" title:@"0006#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *useHelp1 = [QCPileListCellModel itemWithIcon:@"setting_help" title:@"0007#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *comQuestion1 = [QCPileListCellModel itemWithIcon:@"setting_answer" title:@"0008#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    
    WQItemModel *everyMsgNumber2 = [QCPileListCellModel itemWithIcon:@"setting_sndNum" title:@"0009#充电桩" subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *setMsgContent2 = [QCPileListCellModel itemWithIcon:@"setting_sign" title:@"00010#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *useHelp2 = [QCPileListCellModel itemWithIcon:@"setting_help" title:@"00011#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *comQuestion2 = [QCPileListCellModel itemWithIcon:@"setting_answer" title:@"00012#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    //////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    //group.items = @[clearRecord,openSave,selectedCopy,everyMsgNumber,setMsgContent,useHelp,comQuestion];
    
    group.items = @[everyMsgNumber,setMsgContent,useHelp,comQuestion,
                    everyMsgNumber1,setMsgContent1,useHelp1,comQuestion1,
                    everyMsgNumber2,setMsgContent2,useHelp2,comQuestion2];
    //group.header = @"我是第一组头部内容";
    //group.footer = @"我是第一组尾部内容";
    
    [self.data addObject:group];
    
}


/**
 *  设置UItableView中的数据，并可以从cell缓冲池中取得数据
 *
 *  @param tableView tableView
 *  @param indexPath 第indexPath个tableViewCell
 *
 *  @return tableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1、创建cell
    
    QCPileListCell *cell = [QCPileListCell cellWithTableView:tableView];
    // 2、设置cell数据
    
    WQTableViewGroupModel *group = self.data[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    // 3.返回cell
    return cell;
}
/**
 *  选中tableViewCell执行动作
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WQTableViewGroupModel *group = self.data[indexPath.section];
    WQItemModel *item            = group.items[indexPath.row];
    
    QCPileListCellModel *arrowItem = (QCPileListCellModel *)item;
    // 如果没有需要跳转的控制器
    if (arrowItem.destVcClass == nil) {
        return;
    }
    QCPileListDetailCtrl *vc = [[arrowItem.destVcClass alloc]init];
    vc.title = arrowItem.title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
