//
//  QCFaultRecordCell.h
//  chargePileManage
//
//  Created by YuMing on 16/7/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCFaultRecordModel;

@interface QCFaultRecordCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) QCFaultRecordModel *faultRecordModel;
@end
