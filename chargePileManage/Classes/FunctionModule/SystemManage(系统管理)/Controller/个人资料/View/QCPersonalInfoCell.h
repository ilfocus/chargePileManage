//
//  QCPersonalInfoCell.h
//  chargePileManage
//
//  Created by YuMing on 16/6/17.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCPersonInfoModel;

@interface QCPersonalInfoCell : UITableViewCell
/**
 *  cell的模型数据
 */
@property (nonatomic,strong) QCPersonInfoModel *item;
/**
 *  创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
