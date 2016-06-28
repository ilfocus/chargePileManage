//
//  QCSupplyRecordCell.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSupplyRecordCell.h"
#import "QCSupplyRecordModel.h"

@interface QCSupplyRecordCell ()
@property (nonatomic,weak) UILabel *chargePileNumLbl;
@property (nonatomic,weak) UILabel *chargeTimeLbl;
@property (nonatomic,weak) UILabel *chargeCostLbl;

@property (nonatomic,copy) NSString *userID;  // 桩号
@property (nonatomic,strong) NSString *chargeElectDate;
@property (nonatomic,assign) float supplyElectCost;

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
    
    if (self.userID) {
        chargePileNumLbl.text = [@"用户:" stringByAppendingString:self.userID];
    } else {
        chargePileNumLbl.text = @"用户:";
    }
    chargePileNumLbl.textColor = [UIColor blackColor];
    [self addSubview:chargePileNumLbl];
    self.chargePileNumLbl = chargePileNumLbl;
    
    UILabel *chargeTimeLbl = [UILabel new];
    chargeTimeLbl.font = QCTitleFont;
    
    if (self.chargeElectDate) {
        chargeTimeLbl.text = [@"时间:" stringByAppendingString:self.chargeElectDate];
    } else {
        chargeTimeLbl.text = @"时间";
    }
    
    chargeTimeLbl.textColor = [UIColor blackColor];
    [self addSubview:chargeTimeLbl];
    self.chargeTimeLbl = chargeTimeLbl;
    
    
    UILabel *chargeCostLbl = [UILabel new];
    chargeCostLbl.font = QCTitleFont;
    chargeCostLbl.text = [@"费用:" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.supplyElectCost]];
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
        
        make.height.mas_equalTo(chargePileNumSize.height);
        make.top.equalTo(vs.mas_top).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCStatusCellBorder);
        
    }];
    
    [_chargeTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(chargePileNumSize.height);
        make.top.equalTo(_chargePileNumLbl.mas_bottom).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCStatusCellBorder);
        
    }];
    
    [_chargeCostLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(chargePileNumSize.height);
        make.top.equalTo(_chargeTimeLbl.mas_bottom).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCStatusCellBorder);
        
    }];
}
#pragma - mark getts and setts


- (void) setCpSupplyRecord:(QCSupplyRecordModel *)cpSupplyRecord
{
    _cpSupplyRecord = cpSupplyRecord;
    
    // 设置数据
    _chargePileNumLbl.text = [@"用户:" stringByAppendingString:cpSupplyRecord.userID];
    _chargeTimeLbl.text = [@"时间:" stringByAppendingString:cpSupplyRecord.chargeElectDate];
    _chargeCostLbl.text = [@"费用:" stringByAppendingString:[NSString stringWithFormat:@"%.2f",cpSupplyRecord.supplyElectCost]];
}
@end
