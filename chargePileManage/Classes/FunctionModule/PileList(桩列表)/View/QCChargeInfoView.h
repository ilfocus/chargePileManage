//
//  QCChargeInfoView.h
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCPileListDataMode;
@interface QCChargeInfoView : UIButton
@property (nonatomic,assign) float totalQuantity;
@property (nonatomic,assign) float totalFee;
@property (nonatomic,assign) float averagePrice;
@property (nonatomic,assign) float averageFee;

- (void)refreshChargeInfoViewData:(QCPileListDataMode *)modeData;
@end
