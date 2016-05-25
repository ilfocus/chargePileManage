//
//  QCTableBar.m
//  chargePileManage
//
//  Created by YuMing on 16/5/25.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCTableBar.h"
#import "QCTableBarButton.h"

#define isAddMidButton NO

@interface QCTableBar()


@property (nonatomic,weak) UIButton *pluseButton;   // 中间按钮


@property (nonatomic,weak) QCTableBarButton *selectedButton;

/**
 *  存储tabBar状态栏上的UIButton按钮
 */
@property (nonatomic,strong) NSMutableArray *tabBarButtons;
@end

@implementation QCTableBar


/**
 *  创建数组，用于装tabbarItems中的按键
 *  懒加载，用到数组时则加载
 *  @return 可变数组
 */
- (NSMutableArray *) tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];// 保证数组永远有值
    }
    return _tabBarButtons;
}

/**
 *  初始化WQTabBar的fram
 *
 *  @param frame fram值
 *
 *  @return 无
 */
- (id) initWithFrame:(CGRect)frame
{
    // 创建UIView对象时会调用initWithFram方法
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            // 百度发现colorWithPatternImage在执行旋转操作时比较损耗内存
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"tabbar_background"]];
        }
        // 在tabBar按钮上添加加号按钮
        if (isAddMidButton) {
            UIButton *pluseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [pluseButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
            [pluseButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
            [pluseButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
            [pluseButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
            pluseButton.bounds = CGRectMake(0, 0, pluseButton.currentBackgroundImage.size.width, pluseButton.currentBackgroundImage.size.height);
            [self addSubview:pluseButton];
            self.pluseButton = pluseButton;
        }
        
    }
    return self;
}
/**
 *  此方法是由TabBarItem来创建按钮
 *
 *  @param item item数据
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    QCTableBarButton *button = [[QCTableBarButton alloc]init];
    [self addSubview:button]; // addSubview会触发layoutSubviews
    
    button.item = item;   // item对象中主要有按钮图片、背影图片以及title
    
    [self.tabBarButtons addObject:button];   // 把按键添加到数组中
    // 4.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 5.默认选中第0个按钮-----添加了加号按钮后，这里应该选中数组的第0个元素
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}
/**
 *  tabBarItem上按钮被点击
 *
 *  @param button 被点击的按钮
 */
- (void)buttonClick:(QCTableBarButton *)button
{
    // 按下按键后，通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        
        // 给每个按钮绑定一个tag，这样才能知道从哪个按钮跳到哪个按钮
        // 按键按下时候，调用代理方法
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
        
        // 让控制器成为WQTabBar代理，就可以监控WQTabBar的动作了
    }
    // 下面三句话过后，按钮值就会相同，就不存源地址和目标地址，所以代理应该在此之前调用
    // 设置按键状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
/**
 *  在这里设置button的大小
 */
- (void) layoutSubviews {    // 此方法必须调用父类方法
    [super layoutSubviews];
    // 提取tabbar的高度与宽度
    CGFloat tabbarH = self.frame.size.height;
    CGFloat tabbarW = self.frame.size.width;
    // 调整加号按钮的frame,加号的其他属性已经在initFram中设置了
    if (isAddMidButton) {
        self.pluseButton.center = CGPointMake(tabbarW * 0.5, tabbarH * 0.5);
    }
    
    CGFloat buttonY = 0;
    CGFloat buttonW = tabbarW / self.subviews.count;
    CGFloat buttonH = tabbarH;
    
    // 1.遍历tabbar中的所有子控件，也就是所有的button
    // tabBarButtons里面没有pluseButton
    for (int i = 0; i < self.tabBarButtons.count; i++) {
        // 2.取出每个button
        QCTableBarButton *button = self.tabBarButtons[i];
        // 3.设置这些button的fram
        CGFloat buttonX = i * buttonW;
        if (isAddMidButton) {
            if (i > 1) {
                buttonX += buttonW;
            }
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 4.给每个按钮绑定一个tag
        button.tag = (NSInteger)i;
    }
}


@end
