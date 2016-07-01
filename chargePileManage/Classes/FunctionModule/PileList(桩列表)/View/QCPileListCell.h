//
//  QCPileListCell.h
//  chargePileManage
//
//  Created by YuMing on 16/5/26.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WQItemModel;
#define PileListCellHeight 70
/** 来源的字体 */
#define QCSubTitleFont [UIFont systemFontOfSize:12]

@interface QCPileListCell : UITableViewCell
/**
 *  cell的模型数据
 */
@property (nonatomic,strong) WQItemModel *item;
// 在这里要返回一个cell，所以不能用void，而且是初始化函数，返回类型可以不定，所以返回类型为instancetype
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
