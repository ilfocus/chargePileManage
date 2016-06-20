//
//  QCSysManageHeaderView.m
//  chargePileManage
//
//  Created by YuMing on 16/6/15.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSysManageHeaderView.h"
#import "YYKit.h"
#import "UIColor+hex.h"

@interface QCSysManageHeaderView ()

@property (nonatomic,weak) UIImageView *userImageView;
@property (nonatomic,weak) UILabel *userNameLbl;
@property (nonatomic,weak) UIImageView *bgImage;
@end


@implementation QCSysManageHeaderView

#pragma mark - init
- (instancetype) init
{
    self = [super init];
    if (self) {
        
        
        
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background"] forState:UIControlStateNormal];
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
//        view.layer.masksToBounds = YES;
//        view.layer.cornerRadius = 8;
//        view.layer.borderWidth = 1.0;
//        view.layer.borderColor = [WQColor(226,226,226) CGColor];
        UIImageView *bgImage = [[UIImageView alloc] init];
        bgImage.backgroundColor = [UIColor flatGreenColorDark];
        //[bgImage setImage:[UIImage resizedImageWithName:@"common_card_background"]];
        [self addSubview:bgImage];
//        [self sendSubviewToBack:bgImage];
//        bgImage.layer.masksToBounds = YES;
//        bgImage.layer.cornerRadius = 8;
//        bgImage.layer.borderWidth = 1.0;
//        bgImage.layer.borderColor = [WQColor(226,226,226) CGColor];
        self.bgImage = bgImage;
        
        [self setupView];
    }
    return self;
}
- (void) setupView
{
    
    UIImageView *userImageView = [[UIImageView alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"icon"];
    userImageView.image = [image imageByRoundCornerRadius:35 borderWidth:1 borderColor:[UIColor whiteColor]];
    
    [self addSubview:userImageView];
    self.userImageView = userImageView;
    
    UILabel *userNameLbl = [[UILabel alloc] init];
    userNameLbl.font = [UIFont systemFontOfSize:13];
    userNameLbl.text = @"我的帐号";
    userNameLbl.textColor = [UIColor whiteColor];
    [self addSubview:userNameLbl];
    self.userNameLbl = userNameLbl;
}

#pragma mark - setup frame
- (void) layoutSubviews
{
    [super layoutSubviews];
    _bgImage.frame = self.bounds;
    
    WEAK_SELF(vs);
    
    CGSize userNameSize = [_userNameLbl.text sizeWithAttributes:@{NSFontAttributeName : _userNameLbl.font}];
    
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(userNameSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(_userImageView.mas_bottom).with.offset(QCDetailViewBorder);
    }];
}
@end
