//
//  QCFaultInfoView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCFaultInfoView.h"
#import "QCPileListDataMode.h"
#import "UIView+Round.h"

// view
#import "QCFaultView.h"

@interface QCFaultInfoView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** voltage fault */
@property (nonatomic, weak) QCFaultView *inOverVolFaultView;
@property (nonatomic, weak) QCFaultView *inUnderVolFaultView;
@property (nonatomic, weak) QCFaultView *outOverVolFaultView;
@property (nonatomic, weak) QCFaultView *outUnderVolFaultView;
/** current fault */
@property (nonatomic, weak) QCFaultView *inOverCurFaultView;
@property (nonatomic, weak) QCFaultView *inUnderCurFaultView;
@property (nonatomic, weak) QCFaultView *outOverCurFaultView;
@property (nonatomic, weak) QCFaultView *outUnderCurFaultView;
/** temp fault */
@property (nonatomic,weak) QCFaultView *tempFaultView;
/** short fault */
@property (nonatomic,weak) QCFaultView *shortFaultView;

@property (nonatomic,weak) UIView *faultLed;

@end
@implementation QCFaultInfoView
#pragma mark - init methods
/*
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        
        UIView *faultLed = [[UIView alloc] initWithRoundRect:CGRectMake(0, 0, 14, 14)];
        [self addSubview:faultLed];
        self.faultLed = faultLed;
        
        
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
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor lightGrayColor];
        [self setupTitle];
        [self setupFaultModule];
    }
    return self;
}
/**
 *  set up title
 */
- (void) setupTitle
{
    UILabel *titleLbl = [UILabel new];
    titleLbl.font = QCTitleFont;
    titleLbl.text = @"故障信息";
    [self addSubview:titleLbl];
    self.titleLbl = titleLbl;
}
/**
 *  set up fault module
 */
- (void) setupFaultModule
{
    QCFaultView *inOverVolFaultView = [[QCFaultView alloc] initWithTitle:@"输入过压:" faultState:YES];
    
    [self addSubview:inOverVolFaultView];
    self.inOverVolFaultView = inOverVolFaultView;
    
    QCFaultView *inUnderVolFaultView = [[QCFaultView alloc] initWithTitle:@"输入欠压:" faultState:YES];
    [self addSubview:inUnderVolFaultView];
    self.inUnderVolFaultView = inUnderVolFaultView;
    
    QCFaultView *outOverVolFaultView = [[QCFaultView alloc] initWithTitle:@"输出过压:" faultState:YES];
    [self addSubview:outOverVolFaultView];
    self.outOverVolFaultView = outOverVolFaultView;
    
    QCFaultView *outUnderVolFaultView = [[QCFaultView alloc] initWithTitle:@"输出欠压:" faultState:YES];
    [self addSubview:outUnderVolFaultView];
    self.outUnderVolFaultView = outUnderVolFaultView;
    
    QCFaultView *inOverCurFaultView = [[QCFaultView alloc] initWithTitle:@"输入过流:" faultState:YES];
    [self addSubview:inOverCurFaultView];
    self.inOverCurFaultView = inOverCurFaultView;
    
    QCFaultView *inUnderCurFaultView = [[QCFaultView alloc] initWithTitle:@"输入欠流:" faultState:YES];
    [self addSubview:inUnderCurFaultView];
    self.inUnderCurFaultView = inUnderCurFaultView;
    
    QCFaultView *outOverCurFaultView = [[QCFaultView alloc] initWithTitle:@"输出过流:" faultState:YES];
    [self addSubview:outOverCurFaultView];
    self.outOverCurFaultView = outOverCurFaultView;
    
    QCFaultView *outUnderCurFaultView = [[QCFaultView alloc] initWithTitle:@"输出欠流:" faultState:YES];
    [self addSubview:outUnderCurFaultView];
    self.outUnderCurFaultView = outUnderCurFaultView;
    
    QCFaultView *tempFaultView = [[QCFaultView alloc] initWithTitle:@"温度故障:" faultState:YES];
    [self addSubview:tempFaultView];
    self.tempFaultView = tempFaultView;
    
    QCFaultView *shortFaultView = [[QCFaultView alloc] initWithTitle:@"短路故障:" faultState:YES];
    [self addSubview:shortFaultView];
    self.shortFaultView = shortFaultView;
}
- (void) setFaultModulePosition
{
    WEAK_SELF(vs);
    
    [_inOverVolFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
        
    }];
    [_inUnderVolFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inOverVolFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_outOverVolFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inUnderVolFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_outUnderVolFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outOverVolFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    
    [_inOverCurFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outUnderVolFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_inUnderCurFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inOverCurFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_outOverCurFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inUnderCurFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_outUnderCurFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outOverCurFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    
    [_tempFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outUnderCurFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
    [_shortFaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tempFaultView.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder * 2);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@50);
    }];
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    [self setFaultModulePosition];
    
}
#pragma mark - private methods
- (void) displayFaultLed:(bool)state faultLed:(QCFaultView *)faultLed
{
    if (state) {
        faultLed.blfaultState = NO;
    } else {
        faultLed.blfaultState = YES;
    }
}
- (void)refreshFaultViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    [self displayFaultLed:modeData.cpInOverVol faultLed:_inOverVolFaultView];
    [self displayFaultLed:modeData.cpOutOverVol faultLed:_inUnderVolFaultView];
    [self displayFaultLed:modeData.cpInUnderVol faultLed:_outOverVolFaultView];
    [self displayFaultLed:modeData.cpOutUnderVol faultLed:_outUnderVolFaultView];
    
    [self displayFaultLed:modeData.cpInOverCur faultLed:_inOverCurFaultView];
    [self displayFaultLed:modeData.cpOutOverCur faultLed:_inUnderCurFaultView];
    [self displayFaultLed:modeData.cpInUnderCur faultLed:_outOverCurFaultView];
    [self displayFaultLed:modeData.cpOutUnderCur faultLed:_outUnderCurFaultView];
    
    [self displayFaultLed:modeData.cpTempHigh faultLed:_tempFaultView];
    [self displayFaultLed:modeData.cpOutShort faultLed:_shortFaultView];
    
}
#pragma mark - gets and sets
//- (void) setStrVolFault:(NSString *)strVolFault
//{
//    if (strVolFault == nil) {
//        return;
//    }
//    if (_strVolFault != strVolFault) {
//        _strVolFault = strVolFault;
//        _volFaultLbl.text = [@"电压故障:" stringByAppendingString:strVolFault];
//    }
//}
//- (void) setStrCurFault:(NSString *)strCurFault
//{
//    if (strCurFault == nil) {
//        return;
//    }
//    if (_strCurFault != strCurFault) {
//        _strCurFault = strCurFault;
//        _curFaultLbl.text = [@"电流故障:" stringByAppendingString:strCurFault];
//    }
//}
//- (void) setStrTempFault:(NSString *)strTempFault
//{
//    if (strTempFault == nil) {
//        return;
//    }
//    if (_strTempFault != strTempFault) {
//        _strTempFault = strTempFault;
//        _tempFaultLbl.text = [@"温度故障:" stringByAppendingString:strTempFault];
//    }
//}
//- (void) setStrShortFault:(NSString *)strShortFault
//{
//    if (strShortFault == nil) {
//        return;
//    }
//    if (_strShortFault != strShortFault) {
//        _strShortFault = strShortFault;
//        _shortFaultLbl.text = [@"短路故障:" stringByAppendingString:strShortFault];
//    }
//}
@end
