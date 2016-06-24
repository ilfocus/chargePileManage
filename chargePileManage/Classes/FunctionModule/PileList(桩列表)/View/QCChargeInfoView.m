//
//  QCChargeInfoView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCChargeInfoView.h"
#import "QCPileListDataMode.h"

#import "QCChargeView.h"
// third lib
#import "DXPopover.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"
@interface QCChargeInfoView() <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _popoverWidth;
}

@property (nonatomic, strong) NSArray *configs;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic,weak) UIView *contentView;

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
/* detail information */
@property (nonatomic,weak) UIButton *detailInfoBtn;

@property (nonatomic,weak) QCChargeView *chargeView;


@property (nonatomic,copy) NSString *strPointQuantity;
@property (nonatomic,copy) NSString *strPointPrice;
@property (nonatomic,copy) NSString *strPointFee;

@property (nonatomic,copy) NSString *strPeakQuantity;
@property (nonatomic,copy) NSString *strPeakPrice;
@property (nonatomic,copy) NSString *strPeakFee;

@property (nonatomic,copy) NSString *strFlatQuantity;
@property (nonatomic,copy) NSString *strFlatPrice;
@property (nonatomic,copy) NSString *strFlatFee;

@property (nonatomic,copy) NSString *strValleyQuantity;
@property (nonatomic,copy) NSString *strValleyPrice;
@property (nonatomic,copy) NSString *strValleyFee;

@end

@implementation QCChargeInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        
//        QCChargeView *chargeView = [QCChargeView new];
//        chargeView.frame = CGRectMake(0, 0, 200, 20);
//        chargeView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:chargeView];
//        self.chargeView = chargeView;
        
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
        
        UIButton *detailInfoBtn = [UIButton new];
        [detailInfoBtn setTitle:@"详细信息" forState:UIControlStateNormal];
        detailInfoBtn.titleLabel.font = QCSubTitleFont;
        [detailInfoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [detailInfoBtn addTarget:self action:@selector(clickDetailInfoBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailInfoBtn];
        self.detailInfoBtn = detailInfoBtn;
        
//        // average electricity price
//        UILabel *averageElectPriceLbl = [UILabel new];
//        averageElectPriceLbl.text = [@"平均电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.averagePrice,@" 元/度"]];
//        averageElectPriceLbl.font = QCSubTitleFont;
//        [self addSubview:averageElectPriceLbl];
//        self.averageElectPriceLbl = averageElectPriceLbl;
//        
//        // add short fault
//        UILabel *averageFeeLbl = [UILabel new];
//        averageFeeLbl.text = [@"平均费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",self.averageFee,@" 元"]];
//        averageFeeLbl.font = QCSubTitleFont;
//        [self addSubview:averageFeeLbl];
//        self.averageFeeLbl = averageFeeLbl;
    }
    return self;
}
- (instancetype) initWithPopView:(UIView *)view
{
    self = [self init];
    if (self) {
        UITableView *blueView = [[UITableView alloc] init];
        blueView.frame = CGRectMake(0, 0, _popoverWidth, 350);
        blueView.dataSource = self;
        blueView.delegate = self;
        self.tableView = blueView;
        
        self.contentView = view;
        self.popover = [DXPopover new];
        _popoverWidth = CGRectGetWidth(self.contentView.bounds);
        self.configs = @[@"changeWidth", @"ChangeArrowSize", @"ChangeCornerRadius", @"changeAnimationIn", @"changeAnimationOut", @"changeAnimationSpring", @"changeMaskType"];
        return self;
    }
    
    return self;
}

#pragma mark - private methodes
- (void) clickDetailInfoBtn
{
//    WQLog(@"---contentView---%@",NSStringFromCGRect(self.frame));
//    WQLog(@"---detailInfoBtn---%@",NSStringFromCGRect(self.detailInfoBtn.frame));
//    //self.frame = self.contentView.frame;
////    self.detailInfoBtn.frame = CGRectMake(200, 500, 100, 20);
//    
//    [self updateTableViewFrame];
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.detailInfoBtn.frame), CGRectGetMinY(self.detailInfoBtn.frame) - 5);
//    [self.popover showAtPoint:startPoint popoverPostion:DXPopoverPositionUp withContentView:self.tableView inView:self.contentView];
//    
//    __weak typeof(self)weakSelf = self;
//    self.popover.didDismissHandler = ^{
//        [weakSelf bounceTargetView:weakSelf.detailInfoBtn];
//    };
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        WBPopMenuModel * info = [WBPopMenuModel new];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:200
                                                             item:obj
                                                           action:^(NSInteger index) {
                                                               NSLog(@"index:%ld",(long)index);
                                                               
                                                           }];
    
}
- (NSArray *) titles {
    
    _strPointQuantity   = [@"尖电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.pointQuantity]];
    _strPointQuantity   = [_strPointQuantity stringByAppendingString:@" 度"];
    _strPointPrice      = [@"尖电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.pointPrice]];
    _strPointPrice      = [_strPointPrice stringByAppendingString:@" 度/元"];
    _strPointFee        = [@"尖费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.pointFee]];
    _strPointFee        = [_strPointFee stringByAppendingString:@" 元"];
    
    _strPeakQuantity    = [@"峰电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.peakQuantity]];
    _strPeakQuantity    = [_strPeakQuantity stringByAppendingString:@" 度"];
    _strPeakPrice       = [@"峰电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.peakPrice]];
    _strPeakPrice       = [_strPeakPrice stringByAppendingString:@" 度/元"];
    _strPeakFee         = [@"峰费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.peakFee]];
    _strPeakFee         = [_strPeakFee stringByAppendingString:@" 元"];
    
    _strFlatQuantity    = [@"平电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.flatQuantity]];
    _strFlatQuantity    = [_strFlatQuantity stringByAppendingString:@" 度"];
    _strFlatPrice       = [@"平电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.flatPrice]];
    _strFlatPrice       = [_strFlatPrice stringByAppendingString:@" 度/元"];
    _strFlatFee         = [@"平费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.flatFee]];
    _strFlatFee         = [_strFlatFee stringByAppendingString:@" 元"];
    
    _strValleyQuantity  = [@"谷电量：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.valleyQuantity]];
    _strValleyQuantity  = [_strValleyQuantity stringByAppendingString:@" 度"];
    _strValleyPrice     = [@"谷电价：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.valleyPrice]];
    _strValleyPrice     = [_strValleyPrice stringByAppendingString:@" 度/元"];
    _strValleyFee       = [@"谷费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.valleyFee]];
    _strValleyFee       = [_strValleyFee stringByAppendingString:@" 元"];
    
    
    return @[_strPointQuantity,
             _strPeakQuantity,
             _strFlatQuantity,
             _strValleyQuantity,
             _strPointPrice,
             _strPeakPrice,
             _strFlatPrice,
             _strValleyPrice,
             _strPointFee,
             _strPeakFee,
             _strFlatFee,
             _strValleyFee
             ];
}
- (NSArray *) images {
    return @[@"right_menu_QR@3x",
             @"right_menu_addFri@3x",
             @"right_menu_multichat@3x",
             @"right_menu_sendFile@3x",
             @"right_menu_facetoface@3x",
             @"right_menu_payMoney@3x"];
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
    
    self.pointQuantity = modeData.pointQuantity;
    self.pointPrice = modeData.pointPrice;
    self.pointFee = modeData.pointFee;
    
    self.peakQuantity = modeData.peakQuantity;
    self.peakPrice = modeData.peakPrice;
    self.peakFee = modeData.peakFee;
    
    self.flatQuantity = modeData.flatQuantity;
    self.flatPrice = modeData.flatPrice;
    self.flatFee = modeData.flatFee;
    
    self.valleyQuantity = modeData.valleyQuantity;
    self.valleyPrice = modeData.valleyPrice;
    self.valleyFee = modeData.valleyFee;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLbl.text sizeWithAttributes:@{NSFontAttributeName : _titleLbl.font}];
    CGSize totalQuantityLblSize = [_totalQuantityLbl.text sizeWithAttributes:@{NSFontAttributeName : _totalQuantityLbl.font}];
    CGSize totalFeeLblSize = [_totalFeeLbl.text sizeWithAttributes:@{NSFontAttributeName : _totalFeeLbl.font}];
//    CGSize averageElectPriceLblSize = [_averageElectPriceLbl.text sizeWithAttributes:@{NSFontAttributeName : _averageElectPriceLbl.font}];
//    CGSize averageFeeLblSize = [_averageFeeLbl.text sizeWithAttributes:@{NSFontAttributeName : _averageFeeLbl.font}];
    
    CGFloat runViewH = self.frame.size.height;
    
    CGFloat valuePadding = (runViewH - titleSize.height -  QCDetailViewBorder
                            - totalQuantityLblSize.height
                            - totalFeeLblSize.height
                            - totalFeeLblSize.height ) / 3;
    
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
    [_detailInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_totalFeeLbl.mas_bottom).with.offset(valuePadding);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
        
        make.height.mas_equalTo(totalFeeLblSize.height);
    }];
//    [_averageElectPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        ///make.size.mas_equalTo(averageElectPriceLblSize);
//        make.top.equalTo(_totalFeeLbl.mas_bottom).with.offset(valuePadding);
//        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
//        
//        make.height.mas_equalTo(averageElectPriceLblSize.height);
//    }];
//    
//    [_averageFeeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.size.mas_equalTo(averageFeeLblSize);
//        make.top.equalTo(_averageElectPriceLbl.mas_bottom).with.offset(valuePadding);
//        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
//        
//        make.height.mas_equalTo(averageFeeLblSize.height);
//    }];
    
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

- (void) setPointQuantity:(float)pointQuantity
{
    if (_pointQuantity != pointQuantity) {
        _pointQuantity =  pointQuantity;
        //_averageFeeLbl.text = [@"平均费用：" stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",averageFee,@" 元"]];
    }
}

#pragma mark - popView
static int i = 0;
static int j = 1;
- (void)updateTableViewFrame
{
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.width = _popoverWidth;
    self.tableView.frame = tableViewFrame;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"tableViewNumber---1");
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection---%lu",(unsigned long)self.configs.count);
    return self.configs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.configs[indexPath.row];
    NSLog(@"cellForRowAtIndexPath---%lu",indexPath.row);
    return cell;
}
static CGFloat randomFloatBetweenLowAndHigh(CGFloat low, CGFloat high)
{
    CGFloat diff = high - low;
    return (((CGFloat) rand() / RAND_MAX) * diff) + low;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        int c = i % 3;
        if (c==0) {
            _popoverWidth = 160.0;
        }else if (c==1) {
            _popoverWidth = 250.0;
        }else if (c==2){
            _popoverWidth = CGRectGetWidth(self.superview.bounds);
        }
        i++;
    }else if (indexPath.row ==1) {
        CGSize arrowSize= self.popover.arrowSize;
        arrowSize.width += randomFloatBetweenLowAndHigh(3.0, 5.0);
        arrowSize.height += randomFloatBetweenLowAndHigh(3.0, 5.0);
        self.popover.arrowSize = arrowSize;
    }else if (indexPath.row == 2) {
        self.popover.cornerRadius += randomFloatBetweenLowAndHigh(0.0, 1.0);
    }else if (indexPath.row == 3) {
        self.popover.animationIn = randomFloatBetweenLowAndHigh(0.4, 2.0);
    }else if (indexPath.row == 4) {
        self.popover.animationOut = randomFloatBetweenLowAndHigh(0.4, 2.0);
    }else if (indexPath.row == 5) {
        self.popover.animationSpring = !self.popover.animationSpring;
    }else if (indexPath.row == 6) {
        self.popover.maskType = j%2;
        j++;
    }
    [self.popover dismiss];
    
}
- (void)bounceTargetView:(UIView *)targetView
{
    [UIView animateWithDuration:0.1 animations:^{
        targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            targetView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                targetView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}
@end
