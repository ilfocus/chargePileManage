//
//  QCPileListDataMode.m
//  chargePileManage
//
//  Created by YuMing on 16/5/27.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListDataMode.h"
#import <BmobSDK/Bmob.h>

@implementation QCPileListDataMode

- (instancetype) initWithObject:(BmobObject *)object;
{
    // sampling infomation
    
    
    self.commState = [[object objectForKey:@"CommState"] charValue];
    
    self.currentSOC = [[object objectForKey:@"CurrentSOC"] intValue];
    self.chargeTime = [[object objectForKey:@"ChargeTime"] floatValue];
    self.remainTime = [[object objectForKey:@"RemainTime"] floatValue];
    self.currentVOL = [[object objectForKey:@"currentVOL"] floatValue];
    self.currentCur = [[object objectForKey:@"currentCur"] floatValue];
    self.outPower = [[object objectForKey:@"OutPower"] floatValue];
    self.outQuantity = [[object objectForKey:@"OutQuantity"] floatValue];
    self.accTime = [[object objectForKey:@"ACCTime"] intValue];
    
    // fault infomation
    self.currentAlarmInfo = [object objectForKey:@"currentAlarmInfo"];// array
    
    // rate infomation
    self.totalQuantity = [[object objectForKey:@"TotalQuantity"] floatValue];
    self.totalFee = [[object objectForKey:@"TotalFee"] floatValue];
    self.pointQuantity = [[object objectForKey:@"JianQ"] floatValue];
    self.pointPrice = [[object objectForKey:@"JianPrice"] floatValue];
    self.pointFee = [[object objectForKey:@"JianFee"] floatValue];
    self.peakQuantity = [[object objectForKey:@"fengQ"] floatValue];
    self.peakPrice = [[object objectForKey:@"fengPrice"] floatValue];
    self.peakFee = [[object objectForKey:@"fengFee"] floatValue];
    self.flatQuantity = [[object objectForKey:@"PingQ"] floatValue];
    self.flatPrice = [[object objectForKey:@"PingPrice"] floatValue];
    self.flatFee = [[object objectForKey:@"PingFee"] floatValue];
    self.valleyQuantity = [[object objectForKey:@"GUQ"] floatValue];
    self.valleyPrice = [[object objectForKey:@"GUPrice"] floatValue];
    self.valleyFee = [[object objectForKey:@"GUFee"] floatValue];
    
    // battery array infomation
    self.batterySoc = [[object objectForKey:@"BatterySoc"] floatValue];
    self.bmsState = [[object objectForKey:@"BMSState"] boolValue];
    self.portVol = [[object objectForKey:@"PortVol"] floatValue];
    self.cellNum = [[object objectForKey:@"CellNum"] intValue];
    self.tempNum = [[object objectForKey:@"TempNum"] intValue];
    self.maxVol = [[object objectForKey:@"MaxVol"] floatValue];
    self.maxChargeTemp = [[object objectForKey:@"MaxChargeTemp"] floatValue];
    
    // battery safty infomation
    self.cellMaxVol = [[object objectForKey:@"CellMaxVol"] floatValue];
    self.cellPos = [[object objectForKey:@"CellPos"] intValue];
    self.cellMinVol = [[object objectForKey:@"CellMinVol"] floatValue];
    self.cellMinVolPos = [[object objectForKey:@"CellMinVolPos"] intValue];
    self.maxTemp = [[object objectForKey:@"MaxTemp"] floatValue];
    self.minTemp = [[object objectForKey:@"MinTemp"] floatValue];
    
    // battery alarm infomation
    self.volDataAlarm = [[object objectForKey:@"VolDataAlarm"] boolValue];
    self.sampleVolFault = [[object objectForKey:@"SampleVolFault"] boolValue];
    self.singleVolAlarm = [[object objectForKey:@"SingleVolAlarm"] boolValue];
    self.fanFailFault = [[object objectForKey:@"FanFailFault"] boolValue];
    self.sampleTempFault = [[object objectForKey:@"SampleTempFault"] boolValue];
    
    return self;
}


@end
