//
//  WQBaseCell.h
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WQItemModel;

@interface WQBaseCell : UITableViewCell
/**
 *  cell的模型数据
 */
@property (nonatomic,strong) WQItemModel *item;
/**
 *  创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
