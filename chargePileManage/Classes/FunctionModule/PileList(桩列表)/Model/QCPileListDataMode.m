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
    
    
    self.chargePileAddress = [[object objectForKey:@"ChargePileAddress"] longLongValue];
    self.commState         = [[object objectForKey:@"CommState"] charValue];

    self.currentSOC        = [[object objectForKey:@"CurrentSOC"] intValue];
    self.chargeTime        = [[object objectForKey:@"ChargeTime"] floatValue];
    self.remainTime        = [[object objectForKey:@"RemainTime"] floatValue];
    self.currentAVol       = [[object objectForKey:@"currentAVol"] floatValue];
    self.currentACur       = [[object objectForKey:@"currentACur"] floatValue];
    self.outPower          = [[object objectForKey:@"OutPower"] floatValue];
    self.outQuantity       = [[object objectForKey:@"OutQuantity"] floatValue];
    self.accTime           = [[object objectForKey:@"ACCTime"] intValue];

    // fault infomation
    self.cpInOverVol       = [[object objectForKey:@"cpInOverVol"] boolValue];
    self.cpOutOverVol      = [[object objectForKey:@"cpOutOverVol"] boolValue];
    self.cpInUnderVol      = [[object objectForKey:@"cpInUnderVol"] boolValue];
    self.cpOutUnderVol     = [[object objectForKey:@"cpOutUnderVol"] boolValue];

    self.cpInOverCur       = [[object objectForKey:@"cpInOverCur"] boolValue];
    self.cpOutOverCur      = [[object objectForKey:@"cpOutOverCur"] boolValue];
    self.cpInUnderCur      = [[object objectForKey:@"cpInUnderCur"] boolValue];
    self.cpOutUnderCur     = [[object objectForKey:@"cpOutUnderCur"] boolValue];

    self.cpTempHigh        = [[object objectForKey:@"cpTempHigh"] boolValue];
    self.cpOutShort        = [[object objectForKey:@"cpOutShort"] boolValue];

    // rate infomation
    self.totalQuantity     = [[object objectForKey:@"TotalQuantity"] floatValue];
    self.totalFee          = [[object objectForKey:@"TotalFee"] floatValue];
    self.pointQuantity     = [[object objectForKey:@"JianQ"] floatValue];
    self.pointPrice        = [[object objectForKey:@"JianPrice"] floatValue];
    self.pointFee          = [[object objectForKey:@"JianFee"] floatValue];
    self.peakQuantity      = [[object objectForKey:@"fengQ"] floatValue];
    self.peakPrice         = [[object objectForKey:@"fengPrice"] floatValue];
    self.peakFee           = [[object objectForKey:@"fengFee"] floatValue];
    self.flatQuantity      = [[object objectForKey:@"PingQ"] floatValue];
    self.flatPrice         = [[object objectForKey:@"PingPrice"] floatValue];
    self.flatFee           = [[object objectForKey:@"PingFee"] floatValue];
    self.valleyQuantity    = [[object objectForKey:@"GUQ"] floatValue];
    self.valleyPrice       = [[object objectForKey:@"GUPrice"] floatValue];
    self.valleyFee         = [[object objectForKey:@"GUFee"] floatValue];

    // battery array infomation
    self.batterySOC        = [[object objectForKey:@"BatterySOC"] floatValue];
    self.bmsState          = [[object objectForKey:@"BMSState"] boolValue];
    self.portVol           = [[object objectForKey:@"PortVol"] floatValue];
    self.cellNum           = [[object objectForKey:@"CellNum"] intValue];
    self.tempNum           = [[object objectForKey:@"TempNum"] intValue];
    self.maxVol            = [[object objectForKey:@"MaxVol"] floatValue];
    self.maxChargeTemp     = [[object objectForKey:@"MaxChargeTemp"] floatValue];

    // battery safty infomation
    self.cellMaxVol        = [[object objectForKey:@"CellMaxVol"] floatValue];
    self.cellPos           = [[object objectForKey:@"CellPos"] intValue];
    self.cellMinVol        = [[object objectForKey:@"CellMinVol"] floatValue];
    self.cellMinVolPos     = [[object objectForKey:@"CellMinVolPos"] intValue];
    self.maxTemp           = [[object objectForKey:@"MaxTemp"] floatValue];
    self.minTemp           = [[object objectForKey:@"MinTemp"] floatValue];

    // battery alarm infomation
    self.volDataAlarm      = [[object objectForKey:@"VolDataAlarm"] boolValue];
    self.sampleVolFault    = [[object objectForKey:@"SampleVolFault"] boolValue];
    self.singleVolAlarm    = [[object objectForKey:@"SingleVolAlarm"] boolValue];
    self.fanFailFault      = [[object objectForKey:@"FanFailFault"] boolValue];
    self.sampleTempFault   = [[object objectForKey:@"SampleTempFault"] boolValue];
    
    return self;
}



// 以下的归档技术是一定要掌握的 //

/**
 *  从文件中解析对象时候调用
 */
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.chargePileAddress = [decoder decodeInt64ForKey:@"chargePileAddress"];
        self.commState         = [decoder decodeIntForKey:@"commState"];
        self.currentSOC        = [decoder decodeFloatForKey:@"currentSOC"];
        self.chargeTime        = [decoder decodeIntForKey:@"chargeTime"];
        self.remainTime        = [decoder decodeIntForKey:@"remainTime"];
        self.currentAVol       = [decoder decodeFloatForKey:@"currentAVol"];
        self.currentACur       = [decoder decodeFloatForKey:@"currentACur"];
        self.outPower          = [decoder decodeFloatForKey:@"outPower"];
        self.outQuantity       = [decoder decodeFloatForKey:@"outQuantity"];
        self.accTime           = [decoder decodeIntForKey:@"accTime"];
        ////////////////////// fault infomation //////////////////////
        self.cpInOverVol       = [decoder decodeBoolForKey:@"cpInOverVol"];
        self.cpOutOverVol      = [decoder decodeBoolForKey:@"cpOutOverVol"];
        self.cpInUnderVol      = [decoder decodeBoolForKey:@"cpInUnderVol"];
        self.cpOutUnderVol     = [decoder decodeBoolForKey:@"cpOutUnderVol"];
        self.cpInOverCur       = [decoder decodeBoolForKey:@"cpInOverCur"];
        self.cpOutOverCur      = [decoder decodeBoolForKey:@"cpOutOverCur"];
        self.cpInUnderCur      = [decoder decodeBoolForKey:@"cpInUnderCur"];
        self.cpOutUnderCur     = [decoder decodeBoolForKey:@"cpOutUnderCur"];
        self.cpTempHigh        = [decoder decodeBoolForKey:@"cpTempHigh"];
        self.cpOutShort        = [decoder decodeBoolForKey:@"cpOutShort"];
        ////////////////////// rate infomation ///////////////////////
        self.totalQuantity     = [decoder decodeFloatForKey:@"totalQuantity"];
        self.totalFee          = [decoder decodeFloatForKey:@"totalFee"];
        self.pointQuantity     = [decoder decodeFloatForKey:@"pointQuantity"];
        self.pointPrice        = [decoder decodeFloatForKey:@"pointPrice"];
        self.pointFee          = [decoder decodeFloatForKey:@"pointFee"];
        self.peakQuantity      = [decoder decodeFloatForKey:@"pointQuantity"];
        self.peakPrice         = [decoder decodeFloatForKey:@"pointPrice"];
        self.peakFee           = [decoder decodeFloatForKey:@"pointFee"];
        self.flatQuantity      = [decoder decodeFloatForKey:@"pointQuantity"];
        self.flatPrice         = [decoder decodeFloatForKey:@"pointPrice"];
        self.flatFee           = [decoder decodeFloatForKey:@"pointFee"];
        self.valleyQuantity    = [decoder decodeFloatForKey:@"pointQuantity"];
        self.valleyPrice       = [decoder decodeFloatForKey:@"pointPrice"];
        self.valleyFee         = [decoder decodeFloatForKey:@"pointFee"];
        ////////////////////// battery array infomation ///////////////////////
        self.batterySOC        = [decoder decodeFloatForKey:@"batterySOC"];
        self.bmsState          = [decoder decodeBoolForKey:@"bmsState"];
        self.portVol           = [decoder decodeFloatForKey:@"portVol"];
        self.cellNum           = [decoder decodeIntForKey:@"cellNum"];
        self.tempNum           = [decoder decodeIntForKey:@"tempNum"];
        self.maxVol            = [decoder decodeFloatForKey:@"maxVol"];
        self.maxChargeTemp     = [decoder decodeFloatForKey:@"maxChargeTemp"];
        ////////////////////// battery safty infomation ///////////////////////
        self.cellMaxVol        = [decoder decodeFloatForKey:@"cellMaxVol"];
        self.cellPos           = [decoder decodeIntForKey:@"cellPos"];
        self.cellMinVol        = [decoder decodeFloatForKey:@"cellMinVol"];
        self.cellMinVolPos     = [decoder decodeIntForKey:@"cellMinVolPos"];
        self.maxTemp           = [decoder decodeFloatForKey:@"maxTemp"];
        self.minTemp           = [decoder decodeFloatForKey:@"minTemp"];
        ////////////////////// battery alarm infomation ///////////////////////
        self.volDataAlarm      = [decoder decodeBoolForKey:@"volDataAlarm"];
        self.sampleVolFault    = [decoder decodeBoolForKey:@"sampleVolFault"];
        self.singleVolAlarm    = [decoder decodeBoolForKey:@"singleVolAlarm"];
        self.fanFailFault      = [decoder decodeBoolForKey:@"fanFailFault"];
        self.sampleTempFault   = [decoder decodeBoolForKey:@"sampleTempFault"];
        
    }
    return self;
}
/**
 *  将对象写入文件中调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt64:self.chargePileAddress forKey:@"chargePileAddress"];
    [encoder encodeInt:self.commState forKey:@"commState"];
    [encoder encodeFloat:self.currentSOC forKey:@"currentSOC"];
    [encoder encodeInt:self.chargeTime forKey:@"chargeTime"];
    [encoder encodeInt:self.remainTime forKey:@"remainTime"];
    
    [encoder encodeFloat:self.currentAVol forKey:@"currentAVol"];
    [encoder encodeFloat:self.currentACur forKey:@"currentACur"];
    [encoder encodeFloat:self.outPower forKey:@"outPower"];
    [encoder encodeFloat:self.outQuantity forKey:@"outQuantity"];
    [encoder encodeInt:self.accTime forKey:@"accTime"];
    
    ////////////////////// fault infomation //////////////////////
    [encoder encodeBool:self.cpInOverVol forKey:@"cpInOverVol"];
    [encoder encodeBool:self.cpOutOverVol forKey:@"cpOutOverVol"];
    [encoder encodeBool:self.cpInUnderVol forKey:@"cpInUnderVol"];
    [encoder encodeBool:self.cpOutUnderVol forKey:@"cpOutUnderVol"];
    [encoder encodeBool:self.cpInOverCur forKey:@"cpInOverCur"];
    [encoder encodeBool:self.cpOutOverCur forKey:@"cpOutOverCur"];
    [encoder encodeBool:self.cpInUnderCur forKey:@"cpInUnderCur"];
    [encoder encodeBool:self.cpOutUnderCur forKey:@"cpOutUnderCur"];
    [encoder encodeBool:self.cpTempHigh forKey:@"cpTempHigh"];
    [encoder encodeBool:self.cpOutShort forKey:@"cpOutShort"];
    
    ////////////////////// rate infomation ///////////////////////
    [encoder encodeFloat:self.totalQuantity forKey:@"totalQuantity"];
    [encoder encodeFloat:self.totalFee forKey:@"totalFee"];
    
    [encoder encodeFloat:self.pointQuantity forKey:@"pointQuantity"];
    [encoder encodeFloat:self.pointPrice forKey:@"pointPrice"];
    [encoder encodeFloat:self.pointFee forKey:@"pointFee"];
    [encoder encodeFloat:self.peakQuantity forKey:@"peakQuantity"];
    [encoder encodeFloat:self.peakPrice forKey:@"peakPrice"];
    [encoder encodeFloat:self.peakFee forKey:@"peakFee"];
    [encoder encodeFloat:self.flatQuantity forKey:@"flatQuantity"];
    [encoder encodeFloat:self.flatPrice forKey:@"flatPrice"];
    [encoder encodeFloat:self.flatFee forKey:@"flatFee"];
    [encoder encodeFloat:self.valleyQuantity forKey:@"valleyQuantity"];
    [encoder encodeFloat:self.valleyPrice forKey:@"valleyPrice"];
    [encoder encodeFloat:self.valleyFee forKey:@"valleyFee"];
    ////////////////////// battery array infomation ///////////////////////
    [encoder encodeFloat:self.batterySOC forKey:@"batterySOC"];
    [encoder encodeBool:self.bmsState forKey:@"bmsState"];
    [encoder encodeFloat:self.portVol forKey:@"portVol"];
    [encoder encodeInt:self.cellNum forKey:@"cellNum"];
    [encoder encodeInt:self.tempNum forKey:@"tempNum"];
    [encoder encodeFloat:self.maxVol forKey:@"maxVol"];
    [encoder encodeFloat:self.maxChargeTemp forKey:@"maxChargeTemp"];
    ////////////////////// battery safty infomation ///////////////////////
    [encoder encodeFloat:self.cellMaxVol forKey:@"cellMaxVol"];
    [encoder encodeInt:self.cellPos forKey:@"cellPos"];
    [encoder encodeFloat:self.cellMinVol forKey:@"cellMinVol"];
    [encoder encodeInt:self.cellMinVolPos forKey:@"cellMinVolPos"];
    [encoder encodeFloat:self.maxTemp forKey:@"maxTemp"];
    [encoder encodeFloat:self.minTemp forKey:@"minTemp"];
    ////////////////////// battery alarm infomation ///////////////////////
    [encoder encodeBool:self.volDataAlarm forKey:@"volDataAlarm"];
    [encoder encodeBool:self.sampleVolFault forKey:@"sampleVolFault"];
    [encoder encodeBool:self.singleVolAlarm forKey:@"singleVolAlarm"];
    [encoder encodeBool:self.fanFailFault forKey:@"fanFailFault"];
    [encoder encodeBool:self.sampleTempFault forKey:@"sampleTempFault"];
}
@end
