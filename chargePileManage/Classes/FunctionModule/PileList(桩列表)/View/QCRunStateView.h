//
//  QCRunStateView.h
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCPileListDataMode;
@interface QCRunStateView : UIButton
@property (nonatomic,assign) float voltage;
@property (nonatomic,assign) float current;
@property (nonatomic,copy) NSString *currentState;

- (void) refreshViewData:(QCPileListDataMode *)modeData;
@end
