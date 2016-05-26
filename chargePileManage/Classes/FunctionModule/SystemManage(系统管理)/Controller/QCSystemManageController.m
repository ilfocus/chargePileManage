//
//  QCSystemManageController.m
//  chargePileManage
//
//  Created by YuMing on 16/5/25.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSystemManageController.h"

#import "WQItemModel.h"
#import "WQItemArrowModel.h"
#import "WQItemSwitchModel.h"
#import "WQItemLabelModel.h"
#import "WQTableViewGroupModel.h"

@interface QCSystemManageController ()

@end

@implementation QCSystemManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setGroup0];
    [self setGroup1];
}

/**
 * 设置第0组样式
 */
- (void)setGroup0
{
    //WQItemModel *clearRecord = [WQItemSwitchModel itemWithIcon:@"setting_clear" title:@"发送完成后清除记录"];album
    WQItemModel *clearRecord = [WQItemSwitchModel itemWithIcon:@"album" title:@"发送完成后清除记录"];
    WQItemModel *openSave = [WQItemSwitchModel itemWithIcon:@"setting_draft" title:@"开启草稿保存功能"];
    WQItemModel *selectedCopy = [WQItemSwitchModel itemWithIcon:@"setting_copy" title:@"模板内容选中就拷贝"];
    ///////////////////////////////// 有设置目标控制器 /////////////////////////////////////////////////
    WQItemModel *everyMsgNumber = [WQItemArrowModel itemWithIcon:@"setting_sndNum" title:@"每次群发数量" destVcClass:nil];
    WQItemModel *setMsgContent = [WQItemArrowModel itemWithIcon:@"setting_sign" title:@"设置短信签名" destVcClass:nil];
    WQItemModel *useHelp = [WQItemArrowModel itemWithIcon:@"setting_help" title:@"使用帮助" destVcClass:nil];
    WQItemModel *comQuestion = [WQItemArrowModel itemWithIcon:@"setting_answer" title:@"常见问题解答" destVcClass:nil];
    //////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    group.items = @[clearRecord,openSave,selectedCopy,everyMsgNumber,setMsgContent,useHelp,comQuestion];
    
    group.header = @"我是第一组头部内容";
    group.footer = @"我是第一组尾部内容";
    
    [self.data addObject:group];
    
}
/**
 * 设置第1组样式
 */
- (void)setGroup1
{
    WQItemModel *moreSoft = [WQItemArrowModel itemWithIcon:@"setting_more" title:@"更多精品软件" destVcClass:nil];
    WQItemModel *suggestion = [WQItemArrowModel itemWithIcon:@"setting_feedback" title:@"问题与建议反馈" destVcClass:nil];
    WQItemModel *score = [WQItemArrowModel itemWithIcon:@"setting_rate" title:@"给短信小秘书打分" destVcClass:nil];
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    
    group.items = @[moreSoft,suggestion,score];
    group.header = @"我是第二组头部内容";
    group.footer = @"我是第二组尾部内容";
    [self.data addObject:group];
}
@end
