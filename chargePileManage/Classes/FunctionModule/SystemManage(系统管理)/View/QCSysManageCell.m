//
//  QCSysManageCell.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSysManageCell.h"

@implementation QCSysManageCell


#pragma mark - init
//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID = @"QCSysManageCell";
//    
//    QCSysManageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[QCSysManageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    return cell;
//}
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // 添加顶部的view
//        self.backgroundColor = [UIColor orangeColor];
//        [self setupCellView];
//    }
//    return self;
//}
//
//- (void) setupCellView {
//}
//
//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//    
////    WEAK_SELF(vs);
//    
////    CGSize chargePileNumSize = [_chargePileNumLbl.text sizeWithAttributes:@{NSFontAttributeName : _chargePileNumLbl.font}];
////    
////    [_chargePileNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
////        
////        make.size.mas_equalTo(chargePileNumSize);
////        
////        make.top.equalTo(vs.mas_top).with.offset(QCStatusCellBorder);
////        
////        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
////        
////    }];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
