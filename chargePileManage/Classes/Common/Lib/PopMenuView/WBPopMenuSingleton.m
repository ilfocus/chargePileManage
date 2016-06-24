//
//  WBPopMenuSingleton.m
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBPopMenuSingleton.h"
#import "WBPopMenuView.h"

@interface WBPopMenuSingleton ()
@property (nonatomic, strong) WBPopMenuView * popMenuView;
@end

@implementation WBPopMenuSingleton

/**
 *  创建PopMenu单例对象
 *
 *  @return 返回WBPopMenuSingleton对象
 */
+ (WBPopMenuSingleton *) shareManager {
    static WBPopMenuSingleton *_PopMenuSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _PopMenuSingleton = [[WBPopMenuSingleton alloc]init];
    });
    return _PopMenuSingleton;
}

- (void) showPopMenuSelecteWithFrame:(CGFloat)width
                                item:(NSArray *)item
                              action:(void (^)(NSInteger))action {
    
    __weak __typeof(&*self)weakSelf = self;
    if (self.popMenuView != nil) {
        [weakSelf hideMenu];
    }
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    
    self.popMenuView = [[WBPopMenuView alloc]initWithFrame:window.bounds
                                             menuWidth:width
                                                 items:item
                                                action:^(NSInteger index) {
                                                    action(index);
                                                    [weakSelf hideMenu];
                                                }];
    self.popMenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    //self.popMenuView.backgroundColor = [UIColor greenColor];
//    WQLog(@"popMenuView.frame---%@",NSStringFromCGRect(self.popMenuView.frame));
//    WQLog(@"window---%@",NSStringFromCGRect(window.frame));
    [window addSubview:self.popMenuView];
    

    [UIView animateWithDuration:0.3 animations:^{
        if (kIsIphone4Screen) {
//            WQLog(@"Iphone4S");
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.8,0.8);
        } else if(kIsIphone5Screen) {
//            WQLog(@"Iphone5S");
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.9,0.9);
        } else if(kIsIphone6Screen) {
//            WQLog(@"Iphone6S");
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0,1.0);
        } else if(kIsIphone6PlusScreen) {
//            WQLog(@"Iphone6Plus");
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.2,1.2);
        } else if(kIsIpadSeries) {
//            WQLog(@"Ipad");
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.4,1.4);
        }
    }];
}

- (void) hideMenu {
    [UIView animateWithDuration:0.15 animations:^{
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [self.popMenuView.tableView removeFromSuperview];
        [self.popMenuView removeFromSuperview];
        self.popMenuView.tableView = nil;
        self.popMenuView = nil;
    }];
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com