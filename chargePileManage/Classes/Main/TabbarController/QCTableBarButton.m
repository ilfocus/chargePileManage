//
//  QCTableBarButton.m
//  chargePileManage
//
//  Created by YuMing on 16/5/25.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCTableBarButton.h"



// 设置图标的比例
#define WQTabbarButtonImageRatio 0.6

@interface QCTableBarButton()
// 显示提醒数字
@property (nonatomic,weak) UIButton *badgeButton;

@end


@implementation QCTableBarButton

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮上的图片
        
        // 设置按钮图片view中图片显示方法为内容居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
        
        // 设置按钮上文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置按钮字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        if (iOS7) {
            // 设置按钮上字体的颜色
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            // 按钮的背影图片只需要设置一次，所以在初始化fram中进行调用
            [self setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        // 设置选中时的字体颜色
        [self setTitleColor:[UIColor flatGreenColorDark] forState:UIControlStateSelected];
        
        // 添加一个提醒数字按钮
        UIButton *badgeButton = [[UIButton alloc]init];
        // 设置提醒数字背影图片，只需要设置一次
        [self.badgeButton setBackgroundImage:[UIImage imageWithNamed:@"main_badge"] forState:UIControlStateNormal];
        // 设置fram
        CGFloat badgeX = 0;
        CGFloat badgeY = 0;
        CGFloat badgeW = 38;
        CGFloat badgeH = 38;
        self.badgeButton.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        self.badgeButton.hidden = NO;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    if (item.badgeValue) {
        
        self.badgeButton.hidden = NO;
        // 设置文字
        [self.badgeButton setTitle:item.badgeValue forState:UIControlStateNormal];
        
    } else {
        self.badgeButton.hidden = YES;
    }
    
}


/**
 *  重写UIButton的image方法,设置frame
 *
 *  @param contentRect 整个按钮大小
 *
 *  @return image尺寸
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * WQTabbarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW,imageH);
}
/**
 *  重写UIButton的title方法,设置frame
 *
 *  @param contentRect 整个按钮的大小
 *
 *  @return title尺寸
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1.0 - WQTabbarButtonImageRatio);
    
    CGFloat titleY = contentRect.size.height * WQTabbarButtonImageRatio;
    
    return CGRectMake(0, titleY, titleW,titleH);
}
@end
