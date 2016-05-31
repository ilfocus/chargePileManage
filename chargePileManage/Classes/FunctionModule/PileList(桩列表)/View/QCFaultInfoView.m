//
//  QCFaultInfoView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCFaultInfoView.h"
#import "QCPileListDataMode.h"

@interface QCFaultInfoView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** voltage fault */
@property (nonatomic, weak) UILabel *volFaultLbl;
/** current fault */
@property (nonatomic, weak) UILabel *curFaultLbl;
/** temp fault */
@property (nonatomic,weak) UILabel *tempFaultLbl;
/** short fault */
@property (nonatomic,weak) UILabel *shortFaultLbl;

@end
@implementation QCFaultInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"故障信息";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        // add voltage fault
        UILabel *volFaultLbl = [UILabel new];
        volFaultLbl.text = @"电压故障：正常";
        volFaultLbl.font = QCSubTitleFont;
        [self addSubview:volFaultLbl];
        self.volFaultLbl = volFaultLbl;
        
        // add current fault
        UILabel *curFaultLbl = [UILabel new];
        curFaultLbl.text = @"电流故障：正常";
        curFaultLbl.font = QCSubTitleFont;
        [self addSubview:curFaultLbl];
        self.curFaultLbl = curFaultLbl;
        
        // add temp fault
        UILabel *tempFaultLbl = [UILabel new];
        tempFaultLbl.text = @"温度故障：正常";
        tempFaultLbl.font = QCSubTitleFont;
        [self addSubview:tempFaultLbl];
        self.tempFaultLbl = tempFaultLbl;
        
        // add short fault
        UILabel *shortFaultLbl = [UILabel new];
        shortFaultLbl.text = @"短路故障：正常";
        shortFaultLbl.font = QCSubTitleFont;
        [self addSubview:shortFaultLbl];
        self.shortFaultLbl = shortFaultLbl;
    }
    return self;
}
- (void)refreshViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    //self.voltage = modeData.currentVOL;
    //self.current = modeData.currentCur;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    CGSize volFaultLblSize = [_volFaultLbl.text sizeWithAttributes:@{NSFontAttributeName : _volFaultLbl.font}];
    CGSize curFaultLblSize = [_curFaultLbl.text sizeWithAttributes:@{NSFontAttributeName : _curFaultLbl.font}];
    CGSize tempFaultLblSize = [_tempFaultLbl.text sizeWithAttributes:@{NSFontAttributeName : _tempFaultLbl.font}];
    CGSize shortFaultLblSize = [_shortFaultLbl.text sizeWithAttributes:@{NSFontAttributeName : _shortFaultLbl.font}];
    
    CGFloat runViewH = self.frame.size.height;
    
    CGFloat valuePadding = (runViewH - titleSize.height -  QCDetailViewBorder
                            - volFaultLblSize.height
                            - curFaultLblSize.height
                            - tempFaultLblSize.height
                            - shortFaultLblSize.height
                            - 70) / 3;
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_volFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(volFaultLblSize);
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 4);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
    }];
    
    [_curFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(curFaultLblSize);
        make.top.equalTo(_volFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
    }];
    
    [_tempFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(tempFaultLblSize);
        make.top.equalTo(_curFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
    }];
    
    [_shortFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(shortFaultLblSize);
        make.top.equalTo(_tempFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
    }];
    
}
#pragma mark - gets and sets
//- (void)setVoltage:(float)voltage
//{
//    NSString *vol = [@"电压：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", voltage]];
//    vol = [vol stringByAppendingString:@" V"];
//    _volValueLabel.text = vol;
//}
//- (void)setCurrent:(float)current
//{
//    NSString *cur = [@"电流：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", current]];
//    cur = [cur stringByAppendingString:@" A"];
//    _curValueLabel.text = cur;
//}

@end
