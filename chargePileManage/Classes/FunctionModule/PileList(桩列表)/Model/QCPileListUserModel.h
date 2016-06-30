//
//  QCPileListUserModel.h
//  chargePileManage
//
//  Created by YuMing on 16/6/30.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCPileListUserModel : NSObject
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *passWord;
@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *permission;
@property (nonatomic,copy) NSString *area;
@end
