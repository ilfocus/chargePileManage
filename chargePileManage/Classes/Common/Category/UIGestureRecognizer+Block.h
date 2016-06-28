//
//  UIGestureRecognizer+Block.h
//  chargePileManage
//
//  Created by YuMing on 16/6/28.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^QCGestureBlock)(id gestureRecognizer);

@interface UIGestureRecognizer (Block)
+ (instancetype) gestureRecognizerWithActionBlock:(QCGestureBlock) block;
@end
