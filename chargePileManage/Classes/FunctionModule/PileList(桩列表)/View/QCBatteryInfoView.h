//
//  QCBatteryInfoView.h
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCPileListDataMode;
@interface QCBatteryInfoView : UIButton
@property (nonatomic,assign) float batterySoc;
@property (nonatomic,assign) int chargeTime;
@property (nonatomic,assign) int remainTime;
- (void)refreshBatteryInfoViewData:(QCPileListDataMode *)modeData;
@end
