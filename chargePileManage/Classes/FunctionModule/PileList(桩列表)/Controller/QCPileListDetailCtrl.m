//
//  QCPileListDetailCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/5/26.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

// controller
#import "QCPileListDetailCtrl.h"
#import "QCRunStateCtrl.h"
#import "QCFaultInfoCtrl.h"
// model
#import "QCPileListDataMode.h"
// view
#import "QCPileListDetailView.h"
#import "QCRunStateView.h"
#import "QCFaultInfoView.h"
#import "QCChargePileParaView.h"
#import "QCChargeInfoView.h"
#import "QCBatteryInfoView.h"
#import "QCStopCtrlView.h"
#import "QCLoginCtrl.h"
#import "QCDataCacheTool.h"

#import "QCPileListNumModel.h"

// Tool
#import "QCHttpTool.h"
// third lib
#import "MJExtension.h"
#import <BmobSDK/Bmob.h>
#import "YYKit.h"
#import "AFNetworking.h"


@interface QCPileListDetailCtrl ()

@property (nonatomic, strong) NSMutableArray *pileDataArray;
@property (nonatomic,weak) QCRunStateView *runState;
@property (nonatomic,weak) QCFaultInfoView *faultInfo;
@property (nonatomic,weak) QCBatteryInfoView *BatteryDetailView;
@property (nonatomic,weak) QCChargePileParaView *ParaDetailView;
@property (nonatomic,weak) QCStopCtrlView *StopCtrlDetailView;
@property (nonatomic,weak) QCChargeInfoView *ChargeInfoDetailView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,weak) NSTimer *myTimer;
@end

@implementation QCPileListDetailCtrl

static int pileDataCnt = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WQColor(226,226,226);
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSString *dbName = @"chargePileData.sqlite";
//    NSString *sqlCmd = @"create table if not exists t_number (id integer primary key autoincrement,address text,chargePileNum text)";
//
//    QCDataCacheTool *cache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:sqlCmd];
//    QCPileListNumModel *model = [[QCPileListNumModel alloc] init];
//    model.address = @"上海市";
//    model.chargePileNum = @"11111111";
//    QCPileListNumModel *model1 = [[QCPileListNumModel alloc] init];
//    model1.address = @"北京市";
//    model1.chargePileNum = @"22222222";
//    QCPileListNumModel *model2 = [[QCPileListNumModel alloc] init];
//    model2.address = @"深圳市";
//    model2.chargePileNum = @"33333333";
//    QCPileListNumModel *model3 = [[QCPileListNumModel alloc] init];
//    model3.address = @"天津市";
//    model3.chargePileNum = @"44444444";
//    NSArray *arr = @[model,model1,model2,model3];
//    [cache addChargePileDatas:dbName sqlCmd:sqlCmd cpNumArray:arr];
//    
//
    
    NSString *sqlData = @"create table if not exists t_data (id integer primary key autoincrement,address text,cpdata blob)";
    
    QCDataCacheTool *cacheCPData = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:sqlData];
#if SERVER_TYPE
        [QCHttpTool bombQueryData:20 success:^(NSArray *arr) {
            for (QCPileListDataMode *obj in arr) {
                // 保存数据（充电桩数据）到数据库中
                [cacheCPData addChargePileData:dbName sqlData:sqlData cpData:obj];
                [self.pileDataArray addObject:obj];
            }
            // 从数据库读取（充电桩数据）
            NSArray *array = [cacheCPData cpDataWithParam:dbName];
            //WQLog(@"Bomb:cacheCPData---%@",array);
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
#else
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *chargePileID  = [NSString stringWithFormat:@"%d",[self.cpid intValue]];
    //params[@"cpid"] = @"CP000001";
    WQLog(@"充电桩的CPID---%@",chargePileID);
    params[@"cpid"] = chargePileID;
    params[@"datacnt"] = @10;
    
    [QCHttpTool httpQueryCPData:params success:^(id json) {
        
        NSArray *array = json[@"detail"];
        if (array) {
            for (NSDictionary *dict1 in array) {
                QCPileListDataMode *result = [QCPileListDataMode mj_objectWithKeyValues:dict1];
                [cacheCPData addChargePileData:dbName sqlData:sqlData cpData:result];
                WQLog(@"充电桩详细数据---%@",result);
                [self.pileDataArray addObject:result];
            }
            NSArray *array = [cacheCPData cpDataWithParam:dbName];
            WQLog(@"Http:cacheCPData---%@",array);
        }
    } failure:^(NSError *error) {
        WQLog(@"获得数据失败---%@",error);
    }];
#endif
    
    [self setupSubView];
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
    
//    [_myTimer setFireDate:[NSDate distantPast]];
    [_myTimer fire];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [_myTimer setFireDate:[NSDate distantFuture]];
    [_myTimer invalidate];
    _myTimer = nil;
}

- (void) dealloc
{
//    [NSRunLoop mainRunLoop]
    //[_myTimer setFireDate:[NSDate distantFuture]];
    WQLog(@"释放---%@---定时器",self.title);
}


- (void) timerEvent
{
    [self dataRefresh];
}
- (void) dataRefresh
{
    if (self.pileDataArray == nil
        || self.pileDataArray.count == 0) {
        return;
    }
    QCPileListDataMode *pileData = [[QCPileListDataMode alloc] init];
    int count = (int)self.pileDataArray.count;
    
    if (pileDataCnt < count - 1) {
        pileDataCnt ++;
    } else {
        pileDataCnt = 0;
    }
    pileData = self.pileDataArray[pileDataCnt];
    
    WQLog(@"数据刷新---%@",self.title);
    
    [_runState refreshRunStateViewData:pileData];
    [_faultInfo refreshFaultViewData:pileData];
    [_ChargeInfoDetailView refreshChargeInfoViewData:pileData];
    [_BatteryDetailView refreshBatteryInfoViewData:pileData];
}

#pragma mark - init view
- (void) setupViewFrame
{
    CGFloat viewW = (self.view.width - 4 * QCDetailViewBorder) / 2;
    
    //CGFloat viewH = 300;
    
    CGFloat runStateviewH = 200;
    
    CGFloat faultInfoViewH = 280;
    CGFloat BatteryDetailViewH = 200;
    
    CGFloat ParaDetailViewH = 180;
    CGFloat StopCtrlDetailViewH = 220;
    CGFloat ChargeInfoDetailViewH = 160;
    
    
    
    CGFloat firstRowX  = QCDetailViewBorder;
    CGFloat secondRowX = viewW + 2 * QCDetailViewBorder;
    
    CGFloat firstLineY = SPACE_BAR_VIEW;
    
    CGFloat secondeBatteryDetailLineY = runStateviewH + 2 * QCDetailViewBorder + SPACE_BAR_VIEW;
    CGFloat secondeParaDetailViewLineY = faultInfoViewH + 2 * QCDetailViewBorder + SPACE_BAR_VIEW;
    
    
    CGFloat thirdStopCtrlDetailLineY = secondeBatteryDetailLineY + BatteryDetailViewH + 2 * QCDetailViewBorder;
    CGFloat thirdChargeInfoLineY = secondeParaDetailViewLineY + ParaDetailViewH + 2 * QCDetailViewBorder;
    
    
    CGFloat scrollViewH = MAX((thirdStopCtrlDetailLineY + StopCtrlDetailViewH), (thirdChargeInfoLineY + ChargeInfoDetailViewH));
    
    _runState.frame             = CGRectMake(firstRowX, firstLineY, viewW, runStateviewH);
    _faultInfo.frame            = CGRectMake(secondRowX, firstLineY, viewW, faultInfoViewH);
    
    _BatteryDetailView.frame    = CGRectMake(firstRowX, secondeBatteryDetailLineY, viewW, BatteryDetailViewH);
    _ParaDetailView.frame       = CGRectMake(secondRowX, secondeParaDetailViewLineY, viewW, ParaDetailViewH);
    
    _StopCtrlDetailView.frame   = CGRectMake(firstRowX, thirdStopCtrlDetailLineY, viewW, StopCtrlDetailViewH);
    _ChargeInfoDetailView.frame = CGRectMake(secondRowX, thirdChargeInfoLineY, viewW, ChargeInfoDetailViewH);
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollViewH + 20);
}
- (void) setupViewBackGround:(UIButton *) view
{
    [view setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [view setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 8;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [WQColor(226,226,226) CGColor];
}
- (void) setupSubView
{
    
    //WEAK_SELF(vs);
    
    //CGFloat detailViewH = 300;
    
    QCRunStateView *runState = [[QCRunStateView alloc] init];
    [self setupViewBackGround:runState];
    [_scrollView addSubview:runState];
    [runState addTarget:self action:@selector(clickRunState) forControlEvents:UIControlEventTouchUpInside];
    self.runState = runState;
    
    
    QCFaultInfoView *faultInfo = [[QCFaultInfoView alloc] init];
    [self setupViewBackGround:faultInfo];
    //[faultInfo addTarget:self action:@selector(clickFaultInfo) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:faultInfo];
    self.faultInfo = faultInfo;
    
    QCBatteryInfoView *BatteryDetailView = [[QCBatteryInfoView alloc] init];
    [self setupViewBackGround:BatteryDetailView];
    [_scrollView addSubview:BatteryDetailView];
    self.BatteryDetailView = BatteryDetailView;
    
    QCChargePileParaView *ParaDetailView = [[QCChargePileParaView alloc] init];
    [self setupViewBackGround:ParaDetailView];
    [_scrollView addSubview:ParaDetailView];
    self.ParaDetailView = ParaDetailView;
    
    QCStopCtrlView *StopCtrlDetailView = [[QCStopCtrlView alloc] init];
    [self setupViewBackGround:StopCtrlDetailView];
    [_scrollView addSubview:StopCtrlDetailView];
    self.StopCtrlDetailView = StopCtrlDetailView;
    
    
    QCChargeInfoView *ChargeInfoDetailView = [[QCChargeInfoView alloc] init];
    [self setupViewBackGround:ChargeInfoDetailView];
    [_scrollView addSubview:ChargeInfoDetailView];
    self.ChargeInfoDetailView = ChargeInfoDetailView;
    
    
    [self setupViewFrame];
//    [runState mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(vs.view.mas_top).with.offset(69);
//        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(faultInfo.mas_left).with.offset(-QCDetailViewBorder * 2);
//        make.width.equalTo(faultInfo);
//        
//        make.height.mas_equalTo(detailViewH);
//        
//    }];
//    [faultInfo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vs.view.mas_top).with.offset(69);
//        make.left.equalTo(runState.mas_right).with.offset(QCDetailViewBorder * 2);
//        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
//        make.width.equalTo(runState);
//        
//        make.height.mas_equalTo(detailViewH);
//    }];
//    
//    [BatteryDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(runState.mas_bottom).with.offset(QCDetailViewBorder);
//        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(ParaDetailView.mas_left).with.offset(-QCDetailViewBorder * 2);
//        make.width.equalTo(ParaDetailView);
//        
//        make.height.mas_equalTo(detailViewH);
//        
//    }];
//    [ParaDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(faultInfo.mas_bottom).with.offset(QCDetailViewBorder);
//        make.left.equalTo(BatteryDetailView.mas_right).with.offset(QCDetailViewBorder * 2);
//        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
//        make.width.equalTo(BatteryDetailView);
//        
//        make.height.mas_equalTo(detailViewH);
//    }];
//    
//    [StopCtrlDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(BatteryDetailView.mas_bottom).with.offset(QCDetailViewBorder);
//        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(ChargeInfoDetailView.mas_left).with.offset(-QCDetailViewBorder * 2);
//        make.width.equalTo(ChargeInfoDetailView);
//        
//        make.height.mas_equalTo(detailViewH);
//        
//    }];
//    [ChargeInfoDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ParaDetailView.mas_bottom).with.offset(QCDetailViewBorder);
//        make.left.equalTo(StopCtrlDetailView.mas_right).with.offset(QCDetailViewBorder * 2);
//        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
//        make.width.equalTo(StopCtrlDetailView);
//        
//        make.height.mas_equalTo(detailViewH);
//    }];
}
#pragma mark - button click
- (void) clickRunState
{
    //QCRunStateCtrl *runStateCtrl = [[QCRunStateCtrl alloc] init];
    QCLoginCtrl *loginVC = [[QCLoginCtrl alloc] init];
    loginVC.title = @"运行状态";
    //[self.navigationController pushViewController:loginVC animated:YES];
}
- (void) clickFaultInfo
{
    QCFaultInfoCtrl *faultCtrl = [QCFaultInfoCtrl new];
    faultCtrl.title = @"故障信息";
    [self.navigationController pushViewController:faultCtrl animated:YES];
}

#pragma mark - gets and sets
- (NSMutableArray *)pileDataArray {
    if ( _pileDataArray == nil) {
        _pileDataArray = [NSMutableArray array];
    }
    return _pileDataArray;
}
@end
