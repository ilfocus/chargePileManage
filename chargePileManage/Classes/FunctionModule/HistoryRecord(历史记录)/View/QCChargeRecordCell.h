//
//  QCChargeRecordCell.h
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCChargeRecordModel;

@interface QCChargeRecordCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) QCChargeRecordModel *cpRecord;

@end
