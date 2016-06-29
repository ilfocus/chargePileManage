//
//  QCChargeRecordCell.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargeRecordCell.h"
#import "QCChargeRecordModel.h"

@interface QCChargeRecordCell ()
@property (nonatomic,weak) UILabel *chargePileNumLbl;
@property (nonatomic,weak) UILabel *chargeTimeLbl;
@property (nonatomic,weak) UILabel *chargeCostLbl;

@property (nonatomic,copy) NSString *strChargePileNum;
@property (nonatomic,copy) NSString *strChargePileTime;
@property (nonatomic,assign) float fChargePileCost;

@end


@implementation QCChargeRecordCell

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"QCHistoryRecordCell";
    
    QCChargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QCChargeRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加顶部的view
        [self setupCellView];
    }
    return self;
}

- (void) setupCellView {
    
    UILabel *chargePileNumLbl = [UILabel new];
    chargePileNumLbl.font = QCTitleFont;
    
    if (self.strChargePileNum) {
        chargePileNumLbl.text = [@"桩号: " stringByAppendingString:self.strChargePileNum];
    } else {
        chargePileNumLbl.text = @"桩号: ";
    }
    
    chargePileNumLbl.textColor = [UIColor blackColor];
    [self addSubview:chargePileNumLbl];
    self.chargePileNumLbl = chargePileNumLbl;
    
    UILabel *chargeTimeLbl = [UILabel new];
    chargeTimeLbl.font = QCTitleFont;
    if (self.strChargePileTime) {
        chargeTimeLbl.text = [@"时间: " stringByAppendingString:self.strChargePileTime];
    } else {
        chargeTimeLbl.text = @"时间: ";
    }
    
    chargeTimeLbl.textColor = [UIColor blackColor];
    [self addSubview:chargeTimeLbl];
    self.chargeTimeLbl = chargeTimeLbl;
    
    
    UILabel *chargeCostLbl = [UILabel new];
    chargeCostLbl.font = QCTitleFont;
    chargeCostLbl.text = [@"费用: " stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.fChargePileCost]];
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
        make.top.equalTo(vs.mas_top).with.offset(2 * QCStatusCellBorder);
        
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


- (void) setCpRecord:(QCChargeRecordModel *)cpRecord
{
    _cpRecord = cpRecord;
    
    // 设置数据
    _chargePileNumLbl.text = [@"桩号: " stringByAppendingString:cpRecord.cpID];
    _chargeTimeLbl.text = [@"时间: " stringByAppendingString:cpRecord.chargeElectDate];
    _chargeCostLbl.text = [@"费用: " stringByAppendingString:[NSString stringWithFormat:@"%.2f",cpRecord.chargeElectCost]];
}


@end
