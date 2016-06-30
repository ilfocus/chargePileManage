//
//  WQBaseCell.m
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import "WQBaseCell.h"

#import "WQItemModel.h"
#import "WQItemArrowModel.h"
#import "WQItemLabelModel.h"
#import "WQItemSwitchModel.h"
#import "QCItemIconModel.h"
#import "QCItemSegmentModel.h"


#import "UIColor+hex.h"
#import "YYKit.h"


@interface WQBaseCell()
/**
 *  箭头
 */
@property (nonatomic,strong) UIImageView *arrowView;
/**
 *  头像
 */
@property (nonatomic,strong) UIImageView *iconView;
/**
 *  性别选择
 */
@property (nonatomic,strong) UISegmentedControl *segmentedView;
/**
 *  开关
 */
@property (nonatomic,strong) UISwitch *switchView;
/**
 *  标签
 */
@property (nonatomic,strong) UILabel *labelView;

@end

@implementation WQBaseCell

#pragma mark - life cycle

#pragma mark - UITableViewDateSource

#pragma mark - UITableViewDelegate

#pragma mark - CustomDelegate

#pragma mark - event response

#pragma mark - private methods

- (void)switchStateChange
{
    // 开关值存储
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}
- (void) charge:(UISegmentedControl *)segmented
{
    WQLog(@"点击了segmented");
}
/**
 * 设置数据
 */
- (void)setData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subTitle;
}
/**
 *  设置cell右边内容
 */
- (void)setRightContent
{
    if ([self.item isKindOfClass:[WQItemArrowModel class]]) { // 箭头
        self.accessoryView = self.arrowView;
    } else if ([self.item isKindOfClass:[WQItemSwitchModel class]]) { // 开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置开关状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
    } else if ([self.item isKindOfClass:[WQItemLabelModel class]]) { // 标签
        self.accessoryView = self.labelView;
    } else if ([self.item isKindOfClass:[QCItemIconModel class]]) {
        self.accessoryView = self.iconView;
    } else if ([self.item isKindOfClass:[QCItemSegmentModel class]]) {
        self.accessoryView = self.segmentedView;
    } else {
        self.accessoryView = nil;
    }
}
#pragma mark - public  methods
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CELL";
    WQBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WQBaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark - getters and setters

- (void)setItem:(WQItemModel *)item
{
    _item = item;
    
    // 1.设置数据
    [self setData];
    // 2.设置右边按钮
    [self setRightContent];
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}


- (UIImageView *)iconView
{
    if (_iconView == nil) {
        
        _iconView = [UIImageView new];
        
        UIImage *image = [UIImage imageNamed:@"loginIcon"];
        _iconView.image = [image imageByRoundCornerRadius:60 borderWidth:0 borderColor:[UIColor whiteColor]];
       
        _iconView.frame = CGRectMake(0, 0, 60, 60);
        
        _iconView.layer.cornerRadius = _iconView.frame.size.width / 2;
        _iconView.clipsToBounds = YES;
        _iconView.backgroundColor = [UIColor flatWhiteColor];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
//        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalIcon"]];
//        _iconView.frame = CGRectMake(0, 0, 30, 30);
    }
    return _iconView;
}

- (UISegmentedControl *)segmentedView
{
    if (_segmentedView == nil) {
        CGFloat segmentedHeight = 25;
        NSArray *array=@[@"男",@"女"];
        _segmentedView = [[UISegmentedControl alloc] initWithItems:array];
        _segmentedView.frame = CGRectMake(0, 0, 60, segmentedHeight);;
        _segmentedView.selectedSegmentIndex = 0;
        _segmentedView.tintColor = [UIColor colorWithHex:0x15A230];
        [_segmentedView addTarget:self action:@selector(charge:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentedView;
}

@end
