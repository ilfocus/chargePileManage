//
//  QCFaultView.m
//  chargePileManage
//
//  Created by YuMing on 16/6/2.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCFaultView.h"
#import "UIView+Round.h"

@interface QCFaultView ()
/** fault name */
@property (nonatomic,weak) UILabel *faultNameLbl;
@property (nonatomic,weak) UIView *faultLedView;
/** fault name  */
@property (nonatomic,copy) NSString *strFaultName;
@end

@implementation QCFaultView
- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor greenColor];
        UILabel *faultNameLbl = [UILabel new];
        faultNameLbl.font = QCSubTitleFont;
        if (self.strFaultName) {
            faultNameLbl.text = self.strFaultName;
        } else {
            faultNameLbl.text = @"电压故障:";  // 占位
        }
        //faultNameLbl.backgroundColor = [UIColor blueColor];
        [self addSubview:faultNameLbl];
        self.faultNameLbl = faultNameLbl;
        
        UIView *faultLedView = [[UIView alloc] initWithRoundRect:CGRectMake(0, 0, 14, 14)];
        //faultLedView.backgroundColor = [UIColor greenColor];
        [self addSubview:faultLedView];
        self.faultLedView = faultLedView;
    }
    return self;
}
- (instancetype) initWithTitle:(NSString *)title faultState:(bool)faultState
{
    self = [self init];
    self.strFaultName = title;
    self.blfaultState = faultState;
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAK_SELF(vs);
    CGSize faultNameLblSize = [_faultNameLbl.text sizeWithAttributes:@{NSFontAttributeName : _faultNameLbl.font}];
    faultNameLblSize.width  += 2;
    faultNameLblSize.height += 2;
    [_faultNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vs.mas_top);
        make.left.equalTo(vs.mas_left);
        make.size.mas_equalTo(faultNameLblSize);
    }];
    [_faultLedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vs.mas_top);
        make.left.equalTo(_faultNameLbl.mas_right).with.offset(2 * QCDetailViewBorder);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
}
- (void) setStrFaultName:(NSString *)strFaultName
{
    if (strFaultName == nil) {
        return;
    }
    if (_strFaultName != strFaultName) {
        _strFaultName = strFaultName;
        _faultNameLbl.text = strFaultName;
    }
}
- (void) setBlfaultState:(bool)blfaultState
{
    _blfaultState = blfaultState;
    if (blfaultState) {
        _faultLedView.backgroundColor = [UIColor greenColor];
    } else {
        _faultLedView.backgroundColor = [UIColor redColor];
    }
}
@end
