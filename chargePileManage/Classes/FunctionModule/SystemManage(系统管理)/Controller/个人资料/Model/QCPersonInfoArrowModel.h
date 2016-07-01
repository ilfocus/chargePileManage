//
//  QCPersonInfoArrowModel.h
//  chargePileManage
//
//  Created by YuMing on 16/7/1.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPersonInfoModel.h"

@interface QCPersonInfoArrowModel : QCPersonInfoModel

@property (nonatomic,assign) Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
