//
//  QCFaultRecordModel.h
//  chargePileManage
//
//  Created by YuMing on 16/7/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCFaultRecordModel : NSObject

@property (nonatomic,copy) NSString *cpID;  // 桩号
@property (nonatomic,copy) NSString *chargeElectDate;
@property (nonatomic,assign) bool cpInOverVol;
@property (nonatomic,assign) bool cpOutOverVol;
@property (nonatomic,assign) bool cpInUnderVol;
@property (nonatomic,assign) bool cpOutUnderVol;

@property (nonatomic,assign) bool cpInOverCur;
@property (nonatomic,assign) bool cpOutOverCur;
@property (nonatomic,assign) bool cpInUnderCur;
@property (nonatomic,assign) bool cpOutUnderCur;

@property (nonatomic,assign) bool cpTempHigh;
@property (nonatomic,assign) bool cpOutShort;

@end
