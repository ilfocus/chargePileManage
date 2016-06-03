//
//  QCRunStateView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCRunStateView.h"
#import "QCPileListDataMode.h"

@interface QCRunStateView()
/** title */
@property (nonatomic, weak) UILabel *titleLbl;


/** currentState */
@property (nonatomic, weak) UILabel *currentStateLabel;
/** voltage value*/
@property (nonatomic, weak) UILabel *volValueLabel;
/** current value*/
@property (nonatomic, weak) UILabel *curValueLabel;

@end

@implementation QCRunStateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        
        UILabel *titleLbl = [UILabel new];
        
        titleLbl.font = QCTitleFont;
        titleLbl.text = @"运行状态";
        [self addSubview:titleLbl];
        self.titleLbl = titleLbl;
        
        // add voltage value
        UILabel *currentStateLabel = [UILabel new];
        if (self.currentState != nil) {
            NSString *state = [@"当前状态：" stringByAppendingString:self.currentState];
            currentStateLabel.text = state;
        } else {
            currentStateLabel.text = @"当前状态：空闲";
        }
        
        currentStateLabel.font = QCSubTitleFont;
        [self addSubview:currentStateLabel];
        self.currentStateLabel = currentStateLabel;
        
        
        // add voltage value
        UILabel *volValueLabel = [UILabel new];
        NSString *vol = [@"电压：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.voltage]];
        vol = [vol stringByAppendingString:@" V"];
        volValueLabel.text = vol;
        volValueLabel.font = QCSubTitleFont;
        [self addSubview:volValueLabel];
        self.volValueLabel = volValueLabel;
        
        // add current value
        UILabel *curValueLabel = [UILabel new];
        NSString *cur = [@"电流：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.current]];
        cur = [cur stringByAppendingString:@" A"];
        curValueLabel.text = cur;
        curValueLabel.font = QCSubTitleFont;
        [self addSubview:curValueLabel];
        self.curValueLabel = curValueLabel;
    }
    return self;
}
- (void)refreshRunStateViewData:(QCPileListDataMode *)modeData
{
    if (modeData == nil) {
        return;
    }
    self.voltage = modeData.currentVOL;
    self.current = modeData.currentCur;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
//    CGSize titleSize1 = [_titleLbl.text sizeWithFont:_titleLbl.font];
//    WQLog(@"sizeWithAttributes---%@",NSStringFromCGSize(titleSize));
//    WQLog(@"sizeWithFont---%@",NSStringFromCGSize(titleSize1));
    CGSize currentStateLabelSize = [_currentStateLabel.text sizeWithAttributes:@{NSFontAttributeName : _currentStateLabel.font}];
    
    CGSize volValueLabelSize = [_volValueLabel.text sizeWithAttributes:@{NSFontAttributeName : _volValueLabel.font}];
    
    CGSize curValueLabelSize = [_curValueLabel.text sizeWithAttributes:@{NSFontAttributeName : _curValueLabel.font}];
    
    CGFloat runViewH = self.frame.size.height;
    
    
    CGFloat valuePadding = (runViewH - titleSize.height -  QCDetailViewBorder
                            - currentStateLabelSize.height
                            - volValueLabelSize.height
                            - curValueLabelSize.height - 20 - 50) / 2;
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_currentStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.mas_bottom).with.offset(QCDetailViewBorder * 4);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(currentStateLabelSize.height);
    }];
    
    [_volValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentStateLabel.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(volValueLabelSize.height);
    }];
    
    [_curValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_volValueLabel.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(curValueLabelSize.height);
    }];
    
}
#pragma mark - gets and sets
- (void)setVoltage:(float)voltage
{
    if (_voltage != voltage) {
        _voltage = voltage;
        NSString *vol = [@"电压：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", voltage]];
        vol = [vol stringByAppendingString:@" V"];
        _volValueLabel.text = vol;
    }
}
- (void)setCurrent:(float)current
{
    if (_current != current) {
        _current = current;
        NSString *cur = [@"电流：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", current]];
        cur = [cur stringByAppendingString:@" A"];
        _curValueLabel.text = cur;
    }
}
@end
