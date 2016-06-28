//
//  UIGestureRecognizer+Block.m
//  chargePileManage
//
//  Created by YuMing on 16/6/28.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>
static const int target_key;
@implementation UIGestureRecognizer (Block)

+ (instancetype) gestureRecognizerWithActionBlock:(QCGestureBlock)block
{
    return [[self alloc] initWithActionBlock:block];
}

- (instancetype) initWithActionBlock:(QCGestureBlock) block {
    self = [self init];
    [self addActionBlock:block];                    // 绑定block属性
    [self addTarget:self action:@selector(invoke:)];// 得到block属性，并调用block方法
    return self;
}

- (void) addActionBlock:(QCGestureBlock) block
{
    if (block) {
        // 绑定属性
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void) invoke:(id) sender {
    // 获得属性
    QCGestureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}
@end
