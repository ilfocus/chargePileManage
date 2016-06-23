//
//  QCPileListNumModel.m
//  chargePileManage
//
//  Created by YuMing on 16/6/21.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListNumModel.h"
#import <BmobSDK/Bmob.h>

@implementation QCPileListNumModel
#if SERVER_TYPE
- (instancetype) initWithObject:(BmobObject *)object
{
    // sampling infomation
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    self.chargePileNum = [numberFormatter stringFromNumber:[object objectForKey:@"ChargePileAddress"]];
    
    return self;
}
#else

#endif
@end
