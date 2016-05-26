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

@interface QCPileListController ()
//@property (nonatomic, strong) NSMutableArray *pileListCellDatas;
@end

@implementation QCPileListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGroup0];
    
    self.tableView.rowHeight = PileListCellHeight;
}

//- (NSMutableArray *)pileListCellDatas
//{
//    if (_pileListCellDatas == nil) {
//        _pileListCellDatas = [NSMutableArray array];
//    }
//    return _pileListCellDatas;
//}
/**
 * 设置第0组样式
 */
- (void)setGroup0
{
    //WQItemModel *clearRecord = [WQItemSwitchModel itemWithIcon:@"setting_clear" title:@"发送完成后清除记录"];album
//    WQItemModel *clearRecord = [WQItemSwitchModel itemWithIcon:@"album" title:@"发送完成后清除记录" subTitle:@"当前状态"];
//    WQItemModel *openSave = [WQItemSwitchModel itemWithIcon:@"setting_draft" title:@"开启草稿保存功能"];
//    WQItemModel *selectedCopy = [WQItemSwitchModel itemWithIcon:@"setting_copy" title:@"模板内容选中就拷贝"];
    ///////////////////////////////// 有设置目标控制器 /////////////////////////////////////////////////
    WQItemModel *everyMsgNumber = [QCPileListCellModel itemWithIcon:@"setting_sndNum" title:@"0001#充电桩" subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *setMsgContent = [QCPileListCellModel itemWithIcon:@"setting_sign" title:@"0002#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *useHelp = [QCPileListCellModel itemWithIcon:@"setting_help" title:@"0003#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    WQItemModel *comQuestion = [QCPileListCellModel itemWithIcon:@"setting_answer" title:@"0004#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    //////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    //group.items = @[clearRecord,openSave,selectedCopy,everyMsgNumber,setMsgContent,useHelp,comQuestion];
    
    group.items = @[everyMsgNumber,setMsgContent,useHelp,comQuestion];
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
    
    WQLog(@"调用子类tableView方法");
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
