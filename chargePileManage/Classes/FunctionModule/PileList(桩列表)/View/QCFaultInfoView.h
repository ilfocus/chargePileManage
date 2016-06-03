//
//  QCFaultInfoView.h
//  chargePileManage
//
//  Created by YuMing on 16/5/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GREEN_COLOR [UIColor greenColor]
#define RED_COLOR   [UIColor redColor]

@class QCPileListDataMode;
@interface QCFaultInfoView : UIButton

@property (nonatomic,copy) NSString *strVolFault;
@property (nonatomic,copy) NSString *strCurFault;
@property (nonatomic,copy) NSString *strTempFault;
@property (nonatomic,copy) NSString *strShortFault;

- (void) refreshFaultViewData:(QCPileListDataMode *)modeData;
@end
