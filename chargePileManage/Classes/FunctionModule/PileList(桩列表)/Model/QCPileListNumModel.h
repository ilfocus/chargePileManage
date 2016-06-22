//
//  QCPileListNumModel.h
//  chargePileManage
//
//  Created by YuMing on 16/6/21.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;
@interface QCPileListNumModel : NSObject
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) NSString *chargePileNum;

- (instancetype) initWithObject:(BmobObject *)object;
@end
