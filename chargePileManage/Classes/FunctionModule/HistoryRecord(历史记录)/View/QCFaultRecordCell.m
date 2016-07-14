//
//  QCFaultRecordCell.m
//  chargePileManage
//
//  Created by YuMing on 16/7/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCFaultRecordCell.h"
#import "QCFaultRecordModel.h"

@interface QCFaultRecordCell ()
@property (nonatomic,weak) UILabel *chargePileNumLbl;
@property (nonatomic,weak) UILabel *chargeTimeLbl;
@property (nonatomic,weak) UILabel *chargeFaultLbl;

@property (nonatomic,copy) NSString *strChargePileNum;
@property (nonatomic,copy) NSString *strChargePileTime;
@property (nonatomic,assign) float fChargePileCost;
@property (nonatomic,copy) NSString *strFault;
@end

@implementation QCFaultRecordCell

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"QCFaultRecordCell";
    
    QCFaultRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QCFaultRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    
    UILabel *chargeFaultLbl = [UILabel new];
    chargeFaultLbl.font = QCTitleFont;
    
    if (self.strFault) {
        chargeFaultLbl.text = [@"故障: " stringByAppendingString:self.strFault];
    } else {
        chargeFaultLbl.text = @"故障: 无故障";
    }
    
    
    chargeFaultLbl.textColor = [UIColor blackColor];
    [self addSubview:chargeFaultLbl];
    self.chargeFaultLbl = chargeFaultLbl;
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
    
    [_chargeFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(chargePileNumSize.height);
        
        make.top.equalTo(_chargeTimeLbl.mas_bottom).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCStatusCellBorder);
    }];
}

#pragma - mark getts and setts
- (void) setFaultRecordModel:(QCFaultRecordModel *)faultRecordModel
{
    _faultRecordModel = faultRecordModel;
    // 设置数据
    if (faultRecordModel.cpID) {
        _chargePileNumLbl.text = [@"桩号: " stringByAppendingString:faultRecordModel.cpID];
    } else {
        _chargePileNumLbl.text = @"桩号: ";
    }
    if (faultRecordModel.chargeElectDate) {
        _chargeTimeLbl.text = [@"时间: " stringByAppendingString:faultRecordModel.chargeElectDate];
    } else {
        _chargeTimeLbl.text = @"时间";
    }
    _chargeFaultLbl.text = @"故障: ";
    if (faultRecordModel.cpInOverCur) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输入过流 "];
    }
    if (faultRecordModel.cpInOverVol) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输入过压 "];
    }
    if (faultRecordModel.cpInUnderCur) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输入欠流 "];
    }
    if (faultRecordModel.cpInUnderVol) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输入欠压 "];
    }
    
    if (faultRecordModel.cpOutOverCur) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输出过流 "];
    }
    if (faultRecordModel.cpOutOverVol) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输出过压 "];
    }
    if (faultRecordModel.cpOutUnderCur) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输出欠流 "];
    }
    if (faultRecordModel.cpOutUnderVol) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输出欠压 "];
    }
    
    if (faultRecordModel.cpTempHigh) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"温度过高 "];
    }
    if (faultRecordModel.cpOutShort) {
        _chargeFaultLbl.text = [_chargeFaultLbl.text stringByAppendingString:@"输出短路 "];
    }
    
//    _chargeCostLbl.text = [@"费用: " stringByAppendingString:[NSString stringWithFormat:@"%.2f",cpRecord.chargeElectCost]];
}
@end
