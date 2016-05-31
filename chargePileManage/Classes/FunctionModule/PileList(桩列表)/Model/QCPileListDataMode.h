//
//  QCPileListDataMode.h
//  chargePileManage
//
//  Created by YuMing on 16/5/27.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BmobObject;

@interface QCPileListDataMode : NSObject
/**
 *  charge pile address
 */
@property (nonatomic,assign) long chargePileAddress;

///////////////////////  sampling infomation /////////////////
@property (nonatomic,assign) char commState;
@property (nonatomic,assign) float currentSOC;
@property (nonatomic,assign) int chargeTime;
@property (nonatomic,assign) int remainTime;
@property (nonatomic,assign) float currentVOL;
@property (nonatomic,assign) float currentCur;
@property (nonatomic,assign) float outPower;
@property (nonatomic,assign) float outQuantity;
@property (nonatomic,assign) int accTime;

////////////////////// fault infomation //////////////////////
//@property (nonatomic,strong) NSMutableArray *currentAlarmInfo;
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
////////////////////// rate infomation ///////////////////////
@property (nonatomic,assign) float totalQuantity;
@property (nonatomic,assign) float totalFee;
@property (nonatomic,assign) float pointQuantity;
@property (nonatomic,assign) float pointPrice;
@property (nonatomic,assign) float pointFee;

@property (nonatomic,assign) float peakQuantity;
@property (nonatomic,assign) float peakPrice;
@property (nonatomic,assign) float peakFee;

@property (nonatomic,assign) float flatQuantity;
@property (nonatomic,assign) float flatPrice;
@property (nonatomic,assign) float flatFee;

@property (nonatomic,assign) float valleyQuantity;
@property (nonatomic,assign) float valleyPrice;
@property (nonatomic,assign) float valleyFee;
////////////////////// battery array infomation ///////////////////////
@property (nonatomic,assign) float batterySoc;
@property (nonatomic,assign) bool bmsState;
@property (nonatomic,assign) float portVol;
@property (nonatomic,assign) int cellNum;
@property (nonatomic,assign) int tempNum;
@property (nonatomic,assign) float maxVol;
@property (nonatomic,assign) float maxChargeTemp;
////////////////////// battery safty infomation ///////////////////////
@property (nonatomic,assign) float cellMaxVol;
@property (nonatomic,assign) int cellPos;
@property (nonatomic,assign) float cellMinVol;
@property (nonatomic,assign) int cellMinVolPos;
@property (nonatomic,assign) float maxTemp;
@property (nonatomic,assign) float minTemp;
////////////////////// battery alarm infomation ///////////////////////
@property (nonatomic,assign) bool volDataAlarm;
@property (nonatomic,assign) bool sampleVolFault;
@property (nonatomic,assign) bool singleVolAlarm;
@property (nonatomic,assign) bool fanFailFault;
@property (nonatomic,assign) bool sampleTempFault;

- (instancetype) initWithObject:(BmobObject *)object;

@end
