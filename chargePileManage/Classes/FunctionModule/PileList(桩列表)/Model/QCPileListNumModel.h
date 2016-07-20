//
//  QCPileListNumModel.h
//  chargePileManage
//
//  Created by YuMing on 16/6/21.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#if SERVER_TYPE
@class BmobObject;
@interface QCPileListNumModel : NSObject
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) NSString *chargePileNum;
- (instancetype) initWithObject:(BmobObject *)object;
@end
#else
@interface QCPileListNumModel : NSObject

@property (nonatomic,copy) NSString *cpid;
@property (nonatomic,copy) NSString *cpnm;

@property (nonatomic,copy) NSString *commstate;

@property (nonatomic,assign) float price;
@property (nonatomic,assign) int currstate;

@end
#endif
