//
//  QCTableBar.h
//  chargePileManage
//
//  Created by YuMing on 16/5/25.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class QCTableBar;
// 实现代理
@protocol QCTableBarDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param tabBar tabBar---这样就可以知识是点击的哪个tabBar
 *  @param from   源地址
 *  @param to     目标地址
 */
- (void)tabBar:(QCTableBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface QCTableBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
/**
 *  WQTabBar拥有代理
 */
@property (nonatomic,weak) id<QCTableBarDelegate> delegate;

@end
