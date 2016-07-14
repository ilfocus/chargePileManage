//
//  QCBatteryInfoView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCBatteryInfoView.h"
#import "QCPileListDataMode.h"

@interface QCBatteryInfoView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** battery soc image */
@property (nonatomic,weak) UIImageView *batteryImg;

/** soc value */
@property (nonatomic, weak) UILabel *batterySocLbl;
/** charge time */
@property (nonatomic, weak) UILabel *chargeTimeLbl;
/** left time */
@property (nonatomic,weak) UILabel *chargeLeftTimeLbl;

@end
@implementation QCBatteryInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"电池信息";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        UIImageView *batteryImg = [UIImageView new];
        batteryImg.backgroundColor = [UIColor greenColor];
        [self addSubview:batteryImg];
        self.batteryImg = batteryImg;
        
        // battery soc
        UILabel *batterySocLbl = [UILabel new];
        
        int soc = (int)(self.batterySoc * 100);
        batterySocLbl.text = [@"SOC:" stringByAppendingString:[NSString stringWithFormat:@"%d%@",soc,@"%"]];
        batterySocLbl.numberOfLines = 0;
        batterySocLbl.font = QCSubTitleFont;
        [self addSubview:batterySocLbl];
        self.batterySocLbl = batterySocLbl;
        
        // charge time
        UILabel *chargeTimeLbl = [UILabel new];
        chargeTimeLbl.text = [@"充电时间：" stringByAppendingString:[NSString stringWithFormat:@"%d%@",self.chargeTime,@" 分钟"]];
        chargeTimeLbl.font = QCSubTitleFont;
        [self addSubview:chargeTimeLbl];
        self.chargeTimeLbl = chargeTimeLbl;
        
        // charge left time
        UILabel *chargeLeftTimeLbl = [UILabel new];
        chargeLeftTimeLbl.text = [@"剩余时间：" stringByAppendingString:[NSString stringWithFormat:@"%d%@",self.remainTime,@" 分钟"]];
        chargeLeftTimeLbl.font = QCSubTitleFont;
        [self addSubview:chargeLeftTimeLbl];
        self.chargeLeftTimeLbl = chargeLeftTimeLbl;
    }
    return self;
}
- (void)refreshBatteryInfoViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    self.batterySoc = modeData.batterySOC;
    self.chargeTime = modeData.chargeTime;
    self.remainTime = modeData.remainTime;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    CGSize batteryImageSize = CGSizeMake(70, 100);
    
    CGSize batterySocLblSize = [_batterySocLbl.text sizeWithAttributes:@{NSFontAttributeName : _batterySocLbl.font}];
    batterySocLblSize.width += 1;
    batterySocLblSize.height += 1;
    //WQLog(@"%@",NSStringFromCGSize(batterySocLblSize1));
    
    //CGSize batterySocLblSize = [_batterySocLbl.text sizeWithFont:_batterySocLbl.font];
    //WQLog(@"%@",NSStringFromCGSize(batterySocLblSize));
    
    
    CGSize chargeTimeLblSize = [_chargeTimeLbl.text sizeWithAttributes:@{NSFontAttributeName : _chargeTimeLbl.font}];
    CGSize chargeLeftTimeLblSize = [_chargeLeftTimeLbl.text sizeWithAttributes:@{NSFontAttributeName : _chargeLeftTimeLbl.font}];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_batteryImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(batteryImageSize);
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder);
        make.centerX.equalTo(vs.mas_centerX);
    }];
    
    [_batterySocLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(batterySocLblSize);
        make.top.equalTo(_batteryImg.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(_batteryImg.mas_left);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(batterySocLblSize.height);
    }];
    
    [_chargeTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(chargeTimeLblSize);
        make.top.equalTo(_batterySocLbl.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(chargeTimeLblSize.height);
    }];
    
    [_chargeLeftTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(chargeLeftTimeLblSize);
        make.top.equalTo(_chargeTimeLbl.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(chargeLeftTimeLblSize.height);
    }];
    
}
#pragma mark - gets and sets
- (void) setBatterySoc:(float)batterySoc
{
    if (_batterySoc != batterySoc) {
        _batterySoc = batterySoc;
        int soc = (int)(batterySoc * 100);
        _batterySocLbl.text = [@"SOC:" stringByAppendingString:[NSString stringWithFormat:@"%d%@",soc,@"%"]];
    }
}
- (void) setChargeTime:(int)chargeTime
{
    if (_chargeTime != chargeTime) {
        _chargeTime = chargeTime;
        _chargeTimeLbl.text = [@"充电时间：" stringByAppendingString:[NSString stringWithFormat:@"%d%@",chargeTime,@" 分钟"]];
    }
}

- (void) setRemainTime:(int)remainTime
{
    if (_remainTime != remainTime) {
        _remainTime = remainTime;
        _chargeLeftTimeLbl.text = [@"剩余时间：" stringByAppendingString:[NSString stringWithFormat:@"%d%@",remainTime,@" 分钟"]];
    }
}
@end
