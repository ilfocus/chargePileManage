//
//  QCSupplyRecordCell.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSupplyRecordCell.h"

@interface QCSupplyRecordCell ()
@property (nonatomic,weak) UILabel *chargePileNumLbl;
@property (nonatomic,weak) UILabel *chargeTimeLbl;
@property (nonatomic,weak) UILabel *chargeCostLbl;
@end

@implementation QCSupplyRecordCell

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"QCHistoryRecordCell";
    
    QCSupplyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QCSupplyRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加顶部的view
        [self setupCellView];
    }
    return self;
}

- (void) setupCellView {
    
    UILabel *chargePileNumLbl = [UILabel new];
    chargePileNumLbl.font = QCTitleFont;
    chargePileNumLbl.text = @"用户:";
    chargePileNumLbl.textColor = [UIColor blackColor];
    [self addSubview:chargePileNumLbl];
    self.chargePileNumLbl = chargePileNumLbl;
    
    UILabel *chargeTimeLbl = [UILabel new];
    chargeTimeLbl.font = QCTitleFont;
    chargeTimeLbl.text = @"时间:";
    chargeTimeLbl.textColor = [UIColor blackColor];
    [self addSubview:chargeTimeLbl];
    self.chargeTimeLbl = chargeTimeLbl;
    
    
    UILabel *chargeCostLbl = [UILabel new];
    chargeCostLbl.font = QCTitleFont;
    chargeCostLbl.text = @"费用:";
    chargeCostLbl.textColor = [UIColor blackColor];
    [self addSubview:chargeCostLbl];
    self.chargeCostLbl = chargeCostLbl;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize chargePileNumSize = [_chargePileNumLbl.text sizeWithAttributes:@{NSFontAttributeName : _chargePileNumLbl.font}];
    
    [_chargePileNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(chargePileNumSize);
        
        make.top.equalTo(vs.mas_top).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        
    }];
    
    [_chargeTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(chargePileNumSize);
        
        make.top.equalTo(_chargePileNumLbl.mas_bottom).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        
    }];
    
    [_chargeCostLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(chargePileNumSize);
        
        make.top.equalTo(_chargeTimeLbl.mas_bottom).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        
    }];
}

@end
