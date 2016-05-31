//
//  QCPileListDetailView.m
//  chargePileManage
//
//  Created by YuMing on 16/5/27.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCPileListDetailView.h"


@interface QCPileListDetailView()
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/** view内容 */
@property (nonatomic, weak) UIView *contentView;

/** 详细描述 */
@property (nonatomic, weak) UILabel *subTitleLabel;

@end


@implementation QCPileListDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        // add title
        UILabel *titleLabel = [UILabel new];
        //titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.font = QCTitleFont;
        titleLabel.text = @"运行状态";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // add middle View
        UIView *contentView = [UIView new];
        contentView.backgroundColor = [UIColor greenColor];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // add detail explain
        UILabel *subTitleLabel = [UILabel new];
        subTitleLabel.numberOfLines = 0;
        //subTitleLabel.backgroundColor = [UIColor blueColor];
        subTitleLabel.text = @"当前状态：\n"
                              "电压：\n"
                              "电流：\n";
        subTitleLabel.font = QCSubTitleFont;
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
    }
    return self;
}

- (instancetype) initWithTitle:(NSString *)title
{
    self = [self init];
    
    self.titleLabel.text = title;
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAK_SELF(vs);
    
    CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName : _titleLabel.font}];
    CGSize subTitleSize = [_subTitleLabel.text sizeWithAttributes:@{NSFontAttributeName : _subTitleLabel.font}];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(@100);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(QCDetailViewBorder);
        make.bottom.mas_equalTo(_subTitleLabel.mas_top);
        
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.mas_right).with.offset(-QCDetailViewBorder);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(subTitleSize);
        make.bottom.equalTo(vs.mas_bottom).with.offset(-QCDetailViewBorder);
        make.left.equalTo(vs.mas_left).with.offset(QCDetailViewBorder);
    }];
    
}

@end
