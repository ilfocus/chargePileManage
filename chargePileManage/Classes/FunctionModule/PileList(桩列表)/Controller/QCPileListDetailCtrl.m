//
//  QCPileListDetailCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/5/26.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListDetailCtrl.h"

#import "QCPileListDetailView.h"
#import "QCPileListDataMode.h"

#import "QCRunStateView.h"
#import "QCFaultInfoView.h"
#import "QCChargePileParaView.h"
#import "QCChargeInfoView.h"
#import "QCBatteryInfoView.h"
#import "QCStopCtrlView.h"

#import "MJExtension.h"

#import <BmobSDK/Bmob.h>

@interface QCPileListDetailCtrl ()

@property (nonatomic, strong) NSMutableArray *pileDataArray;
@property (nonatomic,weak) QCRunStateView *runState;
@property (nonatomic,weak) QCFaultInfoView *faultInfo;
@property (nonatomic,weak) QCBatteryInfoView *BatteryDetailView;
@property (nonatomic,weak) QCChargePileParaView *ParaDetailView;
@property (nonatomic,weak) QCStopCtrlView *StopCtrlDetailView;
@property (nonatomic,weak) QCChargeInfoView *ChargeInfoDetailView;

@end

@implementation QCPileListDetailCtrl


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WQColor(226,226,226);
    
    
//    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
//    [gameScore setObject:@"小明" forKey:@"playerName"];
//    [gameScore setObject:@78 forKey:@"score"];
//    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
//    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        //进行操作
//        WQLog(@"保存数据成功！！！");
//    }];
    

//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ChargePile"];
//    //查找GameScore表里面id为0c6db13c的数据
//    [bquery getObjectInBackgroundWithId:@"08346e9854" block:^(BmobObject *object,NSError *error){
//        if (error){
//            //进行错误处理
//            NSLog(@"获得数据失败！！！");
//        }else{
//            //表里有id为0c6db13c的数据
//            if (object) {
//                
//                QCPileListDataMode *pileData = [[QCPileListDataMode alloc] initWithObject:object];
//                
//                [self.pileDataArray addObject:pileData];
//            }
//        }
//    }];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ChargePile"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            QCPileListDataMode *pileData = [[QCPileListDataMode alloc] initWithObject:obj];
            [self.pileDataArray addObject:pileData];
        }
    }];
    [self setupSubView];
    
    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [myTimer fire];
    [[NSRunLoop mainRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
}
- (void) timerEvent
{
    [self dataRefresh];
}
- (void) clickRunState
{
    WQLog(@"点击了运行状态！");
}
static int pileDataCnt = 0;
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
        return;
    }
    
    pileData = self.pileDataArray[pileDataCnt];
    
    [_runState refreshRunStateViewData:pileData];
    [_faultInfo refreshFaultViewData:pileData];
    [_ChargeInfoDetailView refreshChargeInfoViewData:pileData];
    [_BatteryDetailView refreshBatteryInfoViewData:pileData];
}


- (void) setupSubView
{
    
    WEAK_SELF(vs);
    
    CGFloat detailViewH = (self.view.frame.size.height - 85) / 3;
    
    QCRunStateView *runState = [[QCRunStateView alloc] init];
    [self.view addSubview:runState];
    [runState addTarget:self action:@selector(clickRunState) forControlEvents:UIControlEventTouchUpInside];
    self.runState = runState;
    
    QCFaultInfoView *faultInfo = [[QCFaultInfoView alloc] init];
    [self.view addSubview:faultInfo];
    self.faultInfo = faultInfo;
    
    QCBatteryInfoView *BatteryDetailView = [[QCBatteryInfoView alloc] init];
    [self.view addSubview:BatteryDetailView];
    self.BatteryDetailView = BatteryDetailView;
    
    QCChargePileParaView *ParaDetailView = [[QCChargePileParaView alloc] init];
    [self.view addSubview:ParaDetailView];
    self.ParaDetailView = ParaDetailView;
    
    QCStopCtrlView *StopCtrlDetailView = [[QCStopCtrlView alloc] init];
    //[StopCtrlDetailView setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    //[StopCtrlDetailView setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:StopCtrlDetailView];
    self.StopCtrlDetailView = StopCtrlDetailView;
    
    
    QCChargeInfoView *ChargeInfoDetailView = [[QCChargeInfoView alloc] init];
    [self.view addSubview:ChargeInfoDetailView];
    self.ChargeInfoDetailView = ChargeInfoDetailView;
    
    [runState mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(vs.view.mas_top).with.offset(69);
        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(faultInfo.mas_left).with.offset(-QCDetailViewBorder * 2);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(faultInfo);
        
    }];
    [faultInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vs.view.mas_top).with.offset(69);
        make.left.equalTo(runState.mas_right).with.offset(QCDetailViewBorder * 2);
        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(runState);
    }];
    
    [BatteryDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(runState.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(ParaDetailView.mas_left).with.offset(-QCDetailViewBorder * 2);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(ParaDetailView);
        
    }];
    [ParaDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(faultInfo.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(BatteryDetailView.mas_right).with.offset(QCDetailViewBorder * 2);
        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(BatteryDetailView);
    }];
    
    [StopCtrlDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(BatteryDetailView.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(ChargeInfoDetailView.mas_left).with.offset(-QCDetailViewBorder * 2);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(ChargeInfoDetailView);
        
    }];
    [ChargeInfoDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ParaDetailView.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(StopCtrlDetailView.mas_right).with.offset(QCDetailViewBorder * 2);
        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
        make.height.mas_equalTo(detailViewH);
        make.width.equalTo(StopCtrlDetailView);
    }];
}



#pragma mark - gets and sets
- (NSMutableArray *)pileDataArray {
    if ( _pileDataArray == nil) {
        _pileDataArray = [NSMutableArray array];
    }
    return _pileDataArray;
}
@end
