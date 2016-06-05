//
//  WBPopMenuView.h
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPopMenuView : UIView

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, copy) NSArray * menuItem;
@property (nonatomic, strong) UITableView * tableView;


- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com