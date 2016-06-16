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
#import "WQTableViewGroupModel.h"

@interface QCPersonalInfoCtrl ()

@end

@implementation QCPersonalInfoCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupView];
}

- (void) setupView
{
    WQItemModel *icon = [WQItemArrowModel itemWithTitle:@"头像" destVcClass:nil];
    WQItemModel *nickName = [WQItemArrowModel itemWithTitle:@"昵称" destVcClass:nil];
    WQItemModel *sex = [WQItemArrowModel itemWithTitle:@"性别" destVcClass:nil];
    WQItemModel *changePwd = [WQItemArrowModel itemWithTitle:@"修改密码" destVcClass:nil];
    WQItemModel *signature = [WQItemArrowModel itemWithTitle:@"个性签名" destVcClass:nil];
    WQItemModel *accountPermission = [WQItemArrowModel itemWithTitle:@"帐号权限" destVcClass:nil];
    WQItemModel *accountStyle = [WQItemArrowModel itemWithTitle:@"帐号类型" destVcClass:nil];
    WQItemModel *address = [WQItemArrowModel itemWithTitle:@"所在小区" destVcClass:nil];
    
    WQTableViewGroupModel *group = [WQTableViewGroupModel new];
    //group.items = @[clearRecord,openSave,selectedCopy,everyMsgNumber,setMsgContent,useHelp,comQuestion];
    
    group.items = @[icon,nickName,sex,changePwd,signature,accountPermission,accountStyle,address];
    //group.header = @"我是第一组头部内容";
    //group.footer = @"我是第一组尾部内容";
    
    [self.data addObject:group];
}

@end
