//
//  QCRecordScrollView.m
//  chargePileManage
//
//  Created by YuMing on 16/7/11.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCRecordScrollView.h"

@implementation QCRecordScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WQLog(@"响应点击事件");
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
