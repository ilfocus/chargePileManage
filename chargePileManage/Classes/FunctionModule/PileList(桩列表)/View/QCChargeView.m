//
//  QCChargeView.m
//  chargePileManage
//
//  Created by YuMing on 16/6/3.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargeView.h"


@interface QCChargeView ()

@property (nonatomic,weak) UILabel *titleLbl;
@property (nonatomic,weak) UILabel *valueLbl;
@property (nonatomic,weak) UILabel *unitLbl;

@end

@implementation QCChargeView

- (instancetype) init
{
    self = [super init];
    if (self) {
        UILabel *titleLbl = [UILabel new];
        titleLbl.font = QCSubTitleFont;
        if (self.strChargeName) {
            titleLbl.text = self.strChargeName;
        } else {
            titleLbl.text = @"充电总电量:";  // 占位
        }
        //titleLbl.backgroundColor = [UIColor blueColor];
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        UILabel *valueLbl = [UILabel new];
        valueLbl.font = QCSubTitleFont;
        if (self.chargeValue) {
            valueLbl.text = [NSString stringWithFormat:@"%.2f",self.chargeValue];
        } else {
            valueLbl.text = @"000000.00";  // 占位
        }
        valueLbl.backgroundColor = [UIColor blueColor];
        [self addSubview:valueLbl];
        self.valueLbl = valueLbl;
        
        UILabel *unitLbl = [UILabel new];
        unitLbl.font = QCSubTitleFont;
        if (self.strUnitName) {
            unitLbl.text = self.strUnitName;
        } else {
            unitLbl.text = @"度/元";  // 占位
        }
        unitLbl.backgroundColor = [UIColor blueColor];
        [self addSubview:unitLbl];
        self.unitLbl = unitLbl;
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    CGFloat lblWidth = self.frame.size.width / 3;
    CGSize titleLblSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    titleLblSize.width += 1;
    titleLblSize.height += 1;
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vs.mas_top);
        make.left.equalTo(vs.mas_left);
        make.size.mas_equalTo(titleLblSize);
    }];
//    [_valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vs.mas_top);
//        make.left.equalTo(_titleLbl.mas_right).width.offset(QCDetailViewBorder);
//        make.right.equalTo(_unitLbl.mas_left).width.offset(QCDetailViewBorder);
//        make.centerX.equalTo(vs.mas_centerX);
//        make.height.mas_equalTo(titleLblSize.height);
//    }];
//    
//    [_unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vs.mas_top);
//        make.left.equalTo(_valueLbl.mas_right).width.offset(QCDetailViewBorder);
//        make.size.mas_equalTo(titleLblSize);
//    }];
    
}

@end
