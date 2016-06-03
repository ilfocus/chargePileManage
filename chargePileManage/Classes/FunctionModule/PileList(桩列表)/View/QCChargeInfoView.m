//
//  QCChargeInfoView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargeInfoView.h"
#import "QCPileListDataMode.h"

@interface QCChargeInfoView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** charge total quantity */
@property (nonatomic, weak) UILabel *totalQuantityLbl;
/** charge total fee */
@property (nonatomic, weak) UILabel *totalFeeLbl;
/** average electricity price*/
@property (nonatomic,weak) UILabel *averageElectPriceLbl;
/** average fee */
@property (nonatomic,weak) UILabel *averageFeeLbl;

@end

@implementation QCChargeInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"充电桩信息";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        // charge total quantity
        UILabel *totalQuantityLbl = [UILabel new];
        totalQuantityLbl.text = [@"充电总电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.totalQuantity,@" 度"]];
        totalQuantityLbl.font = QCSubTitleFont;
        [self addSubview:totalQuantityLbl];
        self.totalQuantityLbl = totalQuantityLbl;
        
        // charge total fee
        UILabel *totalFeeLbl = [UILabel new];
        totalFeeLbl.text = [@"充电总费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.totalFee,@" 元"]];
        totalFeeLbl.font = QCSubTitleFont;
        [self addSubview:totalFeeLbl];
        self.totalFeeLbl = totalFeeLbl;
        
        // average electricity price
        UILabel *averageElectPriceLbl = [UILabel new];
        averageElectPriceLbl.text = [@"平均电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.averagePrice,@" 元/度"]];
        averageElectPriceLbl.font = QCSubTitleFont;
        [self addSubview:averageElectPriceLbl];
        self.averageElectPriceLbl = averageElectPriceLbl;
        
        // add short fault
        UILabel *averageFeeLbl = [UILabel new];
        averageFeeLbl.text = [@"平均费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.averageFee,@" 元"]];
        averageFeeLbl.font = QCSubTitleFont;
        [self addSubview:averageFeeLbl];
        self.averageFeeLbl = averageFeeLbl;
    }
    return self;
}
- (void)refreshChargeInfoViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    self.totalQuantity = modeData.totalQuantity;
    self.totalFee = modeData.totalFee;
    
    self.averagePrice = (modeData.pointPrice + modeData.peakPrice + modeData.flatPrice + modeData.valleyPrice) / 4;
    self.averageFee = (modeData.pointFee + modeData.peakFee +modeData.flatFee + modeData.valleyFee) / 4;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    CGSize totalQuantityLblSize = [_totalQuantityLbl.text sizeWithAttributes:@{NSFontAttributeName : _totalQuantityLbl.font}];
    CGSize totalFeeLblSize = [_totalFeeLbl.text sizeWithAttributes:@{NSFontAttributeName : _totalFeeLbl.font}];
    CGSize averageElectPriceLblSize = [_averageElectPriceLbl.text sizeWithAttributes:@{NSFontAttributeName : _averageElectPriceLbl.font}];
    CGSize averageFeeLblSize = [_averageFeeLbl.text sizeWithAttributes:@{NSFontAttributeName : _averageFeeLbl.font}];
    
    CGFloat runViewH = self.frame.size.height;
    
    CGFloat valuePadding = (runViewH - titleSize.height -  QCDetailViewBorder
                            - totalQuantityLblSize.height
                            - totalFeeLblSize.height
                            - averageElectPriceLblSize.height
                            - averageFeeLblSize.height
                            - 70) / 3;
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_totalQuantityLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(totalQuantityLblSize);
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 4);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(totalQuantityLblSize.height);
    }];
    
    [_totalFeeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(totalFeeLblSize);
        make.top.equalTo(_totalQuantityLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(totalFeeLblSize.height);
    }];
    
    [_averageElectPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        ///make.size.mas_equalTo(averageElectPriceLblSize);
        make.top.equalTo(_totalFeeLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(averageElectPriceLblSize.height);
    }];
    
    [_averageFeeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(averageFeeLblSize);
        make.top.equalTo(_averageElectPriceLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(averageFeeLblSize.height);
    }];
    
}
#pragma mark - gets and sets
- (void) setTotalQuantity:(float)totalQuantity
{
    if (_totalQuantity != totalQuantity) {
        _totalQuantity = totalQuantity;
        _totalQuantityLbl.text = [@"充电总电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",totalQuantity,@" 度"]];
    }
}
- (void) setTotalFee:(float)totalFee
{
    if (_totalFee != totalFee) {
        _totalFee = totalFee;
        _totalFeeLbl.text = [@"充电总费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",totalFee,@" 元"]];
    }
}
- (void) setAveragePrice:(float)averagePrice
{
    if (_averagePrice != averagePrice) {
        _averagePrice = averagePrice;
        _averageElectPriceLbl.text = [@"平均电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",averagePrice,@" 元/度"]];
    }
}

- (void) setAverageFee:(float)averageFee
{
    if (_averageFee != averageFee) {
        _averageFee =  averageFee;
        _averageFeeLbl.text = [@"平均费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",averageFee,@" 元"]];
    }
}
@end
