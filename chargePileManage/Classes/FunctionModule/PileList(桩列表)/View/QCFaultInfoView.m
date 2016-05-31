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
        if (self.strVolFault) {
            volFaultLbl.text = [@"电压故障：" stringByAppendingString:self.strVolFault];
        } else {
            volFaultLbl.text = @"电压故障：正常";
        }
        volFaultLbl.font = QCSubTitleFont;
        [self addSubview:volFaultLbl];
        self.volFaultLbl = volFaultLbl;
        
        // add current fault
        UILabel *curFaultLbl = [UILabel new];
        if (self.strCurFault) {
            curFaultLbl.text = [@"电流故障:" stringByAppendingString:self.strCurFault];
        } else {
            curFaultLbl.text = @"电流故障:正常";
        }
        curFaultLbl.font = QCSubTitleFont;
        [self addSubview:curFaultLbl];
        self.curFaultLbl = curFaultLbl;
        
        // add temp fault
        UILabel *tempFaultLbl = [UILabel new];
        if (self.strTempFault) {
            tempFaultLbl.text = [@"温度故障:" stringByAppendingString:self.strTempFault];
        } else {
            tempFaultLbl.text = @"温度故障：正常";
        }
        tempFaultLbl.font = QCSubTitleFont;
        [self addSubview:tempFaultLbl];
        self.tempFaultLbl = tempFaultLbl;
        
        // add short fault
        UILabel *shortFaultLbl = [UILabel new];
        if (self.strShortFault) {
            shortFaultLbl.text = [@"短路故障:" stringByAppendingString:self.strShortFault];
        } else {
            shortFaultLbl.text = @"短路故障：正常";
        }
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
        //make.size.mas_equalTo(volFaultLblSize);
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 4);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(volFaultLblSize.height);
    }];
    
    [_curFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(curFaultLblSize);
        make.top.equalTo(_volFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(curFaultLblSize.height);
    }];
    
    [_tempFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(tempFaultLblSize);
        make.top.equalTo(_curFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(tempFaultLblSize.height);
    }];
    
    [_shortFaultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(shortFaultLblSize);
        make.top.equalTo(_tempFaultLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(shortFaultLblSize.height);
    }];
    
}
- (void)refreshFaultViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    
    if (   modeData.cpInOverVol
        || modeData.cpOutOverVol
        || modeData.cpInUnderVol
        || modeData.cpOutUnderVol) {
        self.strVolFault = @"故障";
    } else {
        self.strVolFault = @"正常";
    }
    if (   modeData.cpInOverCur
        || modeData.cpOutOverCur
        || modeData.cpInUnderCur
        || modeData.cpOutUnderCur) {
        self.strCurFault = @"故障";
    } else {
        self.strCurFault = @"正常";
    }
    if (modeData.cpTempHigh) {
        self.strTempFault = @"故障";
    } else {
        self.strTempFault = @"正常";
    }
    if (modeData.cpOutShort) {
        self.strShortFault = @"故障";
    } else {
        self.strShortFault = @"故障";
    }
    
}
#pragma mark - gets and sets
- (void) setStrVolFault:(NSString *)strVolFault
{
    if (strVolFault == nil) {
        return;
    }
    if (_strVolFault != strVolFault) {
        _strVolFault = strVolFault;
        _volFaultLbl.text = [@"电压故障:" stringByAppendingString:strVolFault];
    }
}
- (void) setStrCurFault:(NSString *)strCurFault
{
    if (strCurFault == nil) {
        return;
    }
    if (_strCurFault != strCurFault) {
        _strCurFault = strCurFault;
        _curFaultLbl.text = [@"电流故障:" stringByAppendingString:strCurFault];
    }
}
- (void) setStrTempFault:(NSString *)strTempFault
{
    if (strTempFault == nil) {
        return;
    }
    if (_strTempFault != strTempFault) {
        _strTempFault = strTempFault;
        _tempFaultLbl.text = [@"温度故障:" stringByAppendingString:strTempFault];
    }
}
- (void) setStrShortFault:(NSString *)strShortFault
{
    if (strShortFault == nil) {
        return;
    }
    if (_strShortFault != strShortFault) {
        _strShortFault = strShortFault;
        _shortFaultLbl.text = [@"短路故障:" stringByAppendingString:strShortFault];
    }
    
    
}
@end
