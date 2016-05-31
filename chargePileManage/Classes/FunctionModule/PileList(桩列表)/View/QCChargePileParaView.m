//
//  QCChargePileParaView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargePileParaView.h"
#import "QCPileListDataMode.h"

@interface QCChargePileParaView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** voltage fault */
@property (nonatomic, weak) UILabel *cpEncodeLbl;
/** current fault */
@property (nonatomic, weak) UILabel *cpCategoryLbl;
/** temp fault */
@property (nonatomic,weak) UILabel *dataOfPorductLbl;
/** short fault */
@property (nonatomic,weak) UILabel *cpOfCompanyLbl;

@end
@implementation QCChargePileParaView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"充电桩参数";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        // add voltage fault
        UILabel *cpEncodeLbl = [UILabel new];
        cpEncodeLbl.text = @"电桩编码：1234567890";
        cpEncodeLbl.font = QCSubTitleFont;
        [self addSubview:cpEncodeLbl];
        self.cpEncodeLbl = cpEncodeLbl;
        
        // add current fault
        UILabel *cpCategoryLbl = [UILabel new];
        cpCategoryLbl.text = @"电桩类别：直流";
        cpCategoryLbl.font = QCSubTitleFont;
        [self addSubview:cpCategoryLbl];
        self.cpCategoryLbl = cpCategoryLbl;
        
        // add temp fault
        UILabel *dataOfPorductLbl = [UILabel new];
        dataOfPorductLbl.text = @"出厂日期：2016年05月30日";
        dataOfPorductLbl.font = QCSubTitleFont;
        [self addSubview:dataOfPorductLbl];
        self.dataOfPorductLbl = dataOfPorductLbl;
        
        // add short fault
        UILabel *cpOfCompanyLbl = [UILabel new];
        cpOfCompanyLbl.text = @"出厂产家：上海强辰";
        cpOfCompanyLbl.font = QCSubTitleFont;
        [self addSubview:cpOfCompanyLbl];
        self.cpOfCompanyLbl = cpOfCompanyLbl;
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
    CGSize cpEncodeLblSize = [_cpEncodeLbl.text sizeWithAttributes:@{NSFontAttributeName : _cpEncodeLbl.font}];
    CGSize cpCategoryLblSize = [_cpCategoryLbl.text sizeWithAttributes:@{NSFontAttributeName : _cpCategoryLbl.font}];
    CGSize dataOfPorductLblSize = [_dataOfPorductLbl.text sizeWithAttributes:@{NSFontAttributeName : _dataOfPorductLbl.font}];
    CGSize cpOfCompanyLblSize = [_cpOfCompanyLbl.text sizeWithAttributes:@{NSFontAttributeName : _cpOfCompanyLbl.font}];
    
    CGFloat runViewH = self.frame.size.height;
    
    CGFloat valuePadding = (runViewH - titleSize.height -  QCDetailViewBorder
                            - cpEncodeLblSize.height
                            - cpEncodeLblSize.height
                            - cpEncodeLblSize.height
                            - cpEncodeLblSize.height
                            - 70) / 3;
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_cpEncodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(cpEncodeLblSize);
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 4);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(cpEncodeLblSize.height);
    }];
    
    [_cpCategoryLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(cpCategoryLblSize);
        make.top.equalTo(_cpEncodeLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(cpCategoryLblSize.height);
    }];
    
    [_dataOfPorductLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(dataOfPorductLblSize);
        make.top.equalTo(_cpCategoryLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(dataOfPorductLblSize.height);
    }];
    
    [_cpOfCompanyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(cpOfCompanyLblSize);
        make.top.equalTo(_dataOfPorductLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(cpOfCompanyLblSize.height);
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
