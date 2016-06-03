//
//  QCStopCtrlView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCStopCtrlView.h"
#import "QCPileListDataMode.h"
#import "LLBootstrap.h"

@interface QCStopCtrlView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;
/** chargePileBtn */
@property (nonatomic, weak) UIButton *chargePileButton;
/** start button */
@property (nonatomic, weak) UIButton *startBtn;
/** pause button */
@property (nonatomic,weak) UIButton *pauseBtn;
/** recover button */
@property (nonatomic,weak) UIButton *recoverBtn;
/** stop button */
@property (nonatomic,weak) UIButton *stopBtn;

@end
@implementation QCStopCtrlView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"充电桩启停";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        // execute button
        UIButton *chargePileButton = [UIButton new];
        [chargePileButton setTitle:@"执行" forState:UIControlStateNormal];
        [chargePileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        chargePileButton.titleLabel.font = QCSubTitleFont;
        [self addSubview:chargePileButton];
        self.chargePileButton = chargePileButton;
        
        // start button
        UIButton *startBtn = [UIButton new];
        [startBtn setTitle:@"启动" forState:UIControlStateNormal];
        startBtn.titleLabel.font = QCSubTitleFont;
        [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:startBtn];
        self.startBtn = startBtn;
        
        // pause button
        UIButton *pauseBtn = [UIButton new];
        [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [pauseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pauseBtn.titleLabel.font = QCSubTitleFont;
        
        [self addSubview:pauseBtn];
        self.pauseBtn = pauseBtn;
        
        // recover button
        UIButton *recoverBtn = [UIButton new];
        [recoverBtn setTitle:@"恢复" forState:UIControlStateNormal];
        [recoverBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        recoverBtn.titleLabel.font = QCSubTitleFont;
        
        [self addSubview:recoverBtn];
        self.recoverBtn = recoverBtn;
        
        // stop button
        UIButton *stopBtn = [UIButton new];
        stopBtn.titleLabel.text = @"停止";
        [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
        [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        stopBtn.titleLabel.font = QCSubTitleFont;
        
        [self addSubview:stopBtn];
        self.stopBtn = stopBtn;
        
        
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
    
    CGFloat buttonW = (self.frame.size.width - QCDetailViewBorder * 5) / 4;
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_chargePileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.centerX.equalTo(vs.mas_centerX);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chargePileButton.mas_bottom).with.offset(QCDetailViewBorder * 2);
        
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        
        make.size.mas_equalTo(CGSizeMake(buttonW, 30));
    }];
    
    [_pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chargePileButton.mas_bottom).with.offset(QCDetailViewBorder * 2);
        
        make.left.equalTo(_startBtn.mas_right).with.offset(QCDetailViewBorder);
        make.size.mas_equalTo(CGSizeMake(buttonW, 30));
    }];
    
    [_recoverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chargePileButton.mas_bottom).with.offset(QCDetailViewBorder * 2);
        
        make.left.equalTo(_pauseBtn.mas_right).with.offset(QCDetailViewBorder);
        make.size.mas_equalTo(CGSizeMake(buttonW, 30));
    }];

    [_stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chargePileButton.mas_bottom).with.offset(QCDetailViewBorder * 2);
        make.left.equalTo(_recoverBtn.mas_right).with.offset(QCDetailViewBorder);
        make.size.mas_equalTo(CGSizeMake(buttonW, 30));
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
