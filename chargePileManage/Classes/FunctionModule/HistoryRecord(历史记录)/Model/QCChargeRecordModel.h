//
//  QCChargeRecordModel.h
//  chargePileManage
//
//  Created by YuMing on 16/6/27.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCChargeRecordModel : NSObject

@property (nonatomic,copy) NSString *cpID;  // 桩号
@property (nonatomic,strong) NSString *chargeElectDate;
@property (nonatomic,assign) float chargeElectCost;

@end
