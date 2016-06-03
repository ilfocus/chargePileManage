//
//  QCFaultView.h
//  chargePileManage
//
//  Created by YuMing on 16/6/2.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCFaultView : UIView
@property (nonatomic,assign) bool blfaultState;
- (instancetype) initWithTitle:(NSString *)title faultState:(bool)faultState;
@end
