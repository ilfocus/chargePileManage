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
#import "QCHttpTool.h"
#import "QCPileListNumModel.h"
// third lib
#import "MJExtension.h"
#import "MJRefresh.h"
#import "QCChiBaoZiHeader.h"
#import <BmobSDK/Bmob.h>

// category
#import "NSArray+SortAndDistinct.h"

@interface QCPileListController ()
@end

@implementation QCPileListController
static const CGFloat QCDuration = 2.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGroup0];
    
    [self setupView];
}
/**
 *  设置界面
 */
- (void) setupView
{
    QCChiBaoZiHeader *header = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header = header;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.rowHeight = PileListCellHeight;
}

- (void) updateCPNumber:(NSArray *)arr
{
    NSMutableArray *numArray = [NSMutableArray array];
    if (arr == nil) {
        return;
    }
    NSArray *sortArray = [NSArray numStrArraySortAndDistinct:arr];
    
    if (sortArray == nil) {
        return;
    }
    
    for (NSString *str in sortArray) {
        NSString *cpNumber = [NSString stringWithFormat:@"%04d",[str intValue]];
        NSString *title = [cpNumber stringByAppendingString:@"#充电桩"];
        WQItemModel *everyMsgNumber = [QCPileListCellModel itemWithIcon:@"chargePile" title:title subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
        [numArray addObject:everyMsgNumber];
    }
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    group.items = (NSArray *)numArray;
    
    [self.data removeAllObjects];
    [self.data addObject:group];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData]; // 刷新表格
        [self.tableView.mj_header endRefreshing];// 拿到当前的下拉刷新控件，结束刷新状态
    });
}

- (void) loadNewData
{
#if SERVER_TYPE
    [QCHttpTool bombQueryCPNumber:@"ChargePile3" numOfData:10 success:^(NSArray *arr) {
        
        NSMutableArray *pileNumberArr = [NSMutableArray array];
        for (QCPileListNumModel *obj in arr) {
            [pileNumberArr addObject:obj.chargePileNum];
        }
        [self updateCPNumber:pileNumberArr];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
#else
    [QCHttpTool httpQueryCPNumber:nil success:^(id json) {
        NSArray *array = json[@"detail"];
        if (array) {
            NSMutableArray *cpNumArr = [NSMutableArray array];
            for (NSDictionary *dict1 in array) {
                QCPileListNumModel *result = [QCPileListNumModel mj_objectWithKeyValues:dict1];
                NSString *str = [result.cpid substringFromIndex:2];
                int cpNum = [str intValue];
                NSString *str1 = [NSString stringWithFormat:@"%d",cpNum];
                [cpNumArr addObject:str1];
                WQLog(@"得到数据成功---%@",str1);
            }
            if (cpNumArr) {
                [self updateCPNumber:cpNumArr];
            }
            
        }
    } failure:^(NSError *error) {
        WQLog(@"获得数据失败---%@",error);
    }];
#endif
}
/**
 * 设置第0组样式
 */
- (void)setGroup0
{
    ///////////////////////////////// 有设置目标控制器 /////////////////////////////////////////////////
    WQItemModel *everyMsgNumber = [QCPileListCellModel itemWithIcon:@"setting_sndNum" title:@"0001#充电桩" subTitle:@"当前状态:空闲"destVcClass:[QCPileListDetailCtrl class]];
    everyMsgNumber.costValue = 1234.05;
    WQItemModel *setMsgContent = [QCPileListCellModel itemWithIcon:@"setting_sign" title:@"0002#充电桩" subTitle:@"当前状态:空闲" destVcClass:[QCPileListDetailCtrl class]];
    setMsgContent.costValue = 15.67;
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
    
    group.items = @[everyMsgNumber,setMsgContent,useHelp,comQuestion,
                    everyMsgNumber1,setMsgContent1,useHelp1,comQuestion1,
                    everyMsgNumber2,setMsgContent2,useHelp2,comQuestion2];;
    
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
    
    WQLog(@"group.items---%d",group.items.count);
    WQLog(@"indexPath.row---%d",indexPath.row);   // 去掉的话，数据刷新有问题
    
    if (indexPath.row >= group.items.count) {
        // WQLog(@"indexPath.row > group.items.count");
        return cell;
    }
    
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
