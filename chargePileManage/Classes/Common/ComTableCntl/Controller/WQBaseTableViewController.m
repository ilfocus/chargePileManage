//
//  WQBaseTableViewController.m
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import "WQBaseTableViewController.h"

#import "WQTableViewGroupModel.h"
#import "WQItemModel.h"
#import "WQItemArrowModel.h"
#import "WQItemLabelModel.h"
#import "WQItemSwitchModel.h"

//#import "WQDetailViewController.h"

#import "WQBaseCell.h"

@implementation WQBaseTableViewController
#pragma mark - 通过初始化设置分组样式
//- (instancetype)init
//{
//    return [super initWithStyle:UITableViewStyleGrouped];
//}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  数据源数组懒加载，数组里面装的是tableView的组模型
 */
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - TableView的数据源方法
/**
 *  设置tableView的分组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}
/**
 *  设置每组tableView的cell数目
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WQTableViewGroupModel *group = self.data[section];
    return group.items.count;
    
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
    WQBaseCell *cell = [WQBaseCell cellWithTableView:tableView];
    // 2、设置cell数据
    WQTableViewGroupModel *group = self.data[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}
/**
 *  设置cell的头部数据
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WQTableViewGroupModel *group = self.data[section];
    return group.header;
}
/**
 *  设置cell的尾部数据
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    WQTableViewGroupModel *group = self.data[section];
    return group.footer;
}
#pragma mark - TableView的代理方法
/**
 *  选中tableViewCell执行动作
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这一行，消除阴影
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.执行选中cell，跳转或是执行代码或是弹框
    WQTableViewGroupModel *group = self.data[indexPath.section];
    WQItemModel *item            = group.items[indexPath.row];
    
    if (item.option) {
        item.option();   // 执行block
    } else if ([item isKindOfClass:[WQItemArrowModel class]]) {
        WQItemArrowModel *arrowItem = (WQItemArrowModel *)item;
        // 如果没有需要跳转的控制器
        if (arrowItem.destVcClass == nil) {
            return;
        }
        /*
        if (arrowItem.destVcClass == [WQDetailViewController class]) {
            
            WQDetailViewController *vc = [WQDetailViewController new];
            vc.model = arrowItem;
            [self.navigationController pushViewController:vc animated:YES];
            
            return;
        }*/
        UIViewController *vc = [[arrowItem.destVcClass alloc]init];
        vc.title = arrowItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
