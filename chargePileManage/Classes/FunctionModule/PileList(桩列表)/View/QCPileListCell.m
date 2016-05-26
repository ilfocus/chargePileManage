//
//  QCPileListCell.m
//  chargePileManage
//
//  Created by YuMing on 16/5/26.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListCell.h"

#import "WQItemModel.h"

#import "Masonry.h"   // auto layer
#import "YYKit.h"

/** cell的边框宽度 */
#define QCStatusCellBorder 5

@interface QCPileListCell()
/** 图片 */
@property (nonatomic, weak) UIImageView *iconView;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 子标题 */
@property (nonatomic, weak) UILabel *subTitleLabel;

/**
 *  箭头
 */
@property (nonatomic,strong) UIImageView *arrowView;
@end

@implementation QCPileListCell
#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    QCPileListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QCPileListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加顶部的view
        [self setupCellView];
    }
    return self;
}

- (void) setupCellView {
    
    //self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    //self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    
    // 头像
    UIImageView *iconView = [UIImageView new];
    //iconView.backgroundColor = [UIColor redColor];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 标题
    UILabel *titleLable = [UILabel new];
    //titleLable.backgroundColor = [UIColor greenColor];
    titleLable.font = QCTitleFont;
    titleLable.text = @"XXXX#充电桩";
    titleLable.textColor = [UIColor blackColor];
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
    // 子标题
    UILabel *subTitleLabel = [UILabel new];
    //subTitleLabel.backgroundColor = [UIColor blueColor];
    subTitleLabel.font = QCSubTitleFont;
    subTitleLabel.text = @"当前状态：空闲";
    subTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
    
    
    // 添加最右边箭头
    self.accessoryView = self.arrowView;
}
- (void)setItem:(WQItemModel *)item
{
    _item = item;
    
    // 1.设置数据
    [self setData];
}
- (void) setData {
    if (self.item.icon) {
        self.iconView.image = [UIImage imageNamed:self.item.icon];
    }
    self.titleLabel.text = self.item.title;
    self.subTitleLabel.text = self.item.subTitle;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(57, 57));
        
        make.top.equalTo(vs.mas_top).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(vs.mas_left).with.offset(QCStatusCellBorder);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 40));
        
        make.top.equalTo(vs.mas_top).with.offset(QCStatusCellBorder);
        
        make.left.equalTo(_iconView.mas_right).with.offset(QCStatusCellBorder * 2);
        
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 20));
        
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(-QCStatusCellBorder);
        
        make.left.equalTo(_titleLabel.mas_left);
        
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        UIImage *imageScale = [[UIImage imageNamed:@"common_icon_arrow"] imageByResizeToSize:CGSizeMake(24, 24)];
        _arrowView = [[UIImageView alloc] initWithImage:imageScale];
    }
    return _arrowView;
}
@end
