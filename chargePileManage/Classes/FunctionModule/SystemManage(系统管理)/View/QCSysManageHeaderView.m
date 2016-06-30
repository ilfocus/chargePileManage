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
#import "UIGestureRecognizer+Block.h"

@interface QCSysManageHeaderView () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) UIImageView *userImageView;
@property (nonatomic,weak) UIView *userView;


@property (nonatomic,weak) UILabel *userNameLbl;
@property (nonatomic,weak) UIImageView *bgImage;
@end


@implementation QCSysManageHeaderView

#pragma mark - init
- (instancetype) init
{
    self = [super init];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] init];
        bgImage.backgroundColor = [UIColor flatGreenColorDark];
        [self addSubview:bgImage];
        self.bgImage = bgImage;
        [self setupView];
    }
    return self;
}
- (void) setupView
{
    UIView *userView = [[UIView alloc] init];
    userView.backgroundColor = [UIColor clearColor];
    [self addSubview:userView];
    self.userView = userView;
    
    [userView addGestureRecognizer:[UITapGestureRecognizer gestureRecognizerWithActionBlock:^(id gestureRecognizer) {
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                        initWithTitle:nil
                                        delegate:self
                                        cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                        otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
        [myActionSheet showInView:self.superview];
    }]];
    
    UIImageView *userImageView = [[UIImageView alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"loginIcon"];
    userImageView.image = [image imageByRoundCornerRadius:70 borderWidth:0 borderColor:[UIColor whiteColor]];
    userImageView.frame = CGRectMake(0, 0, 66, 66);
    userImageView.layer.cornerRadius = userImageView.frame.size.width / 2;
    userImageView.clipsToBounds = YES;
    userImageView.backgroundColor = [UIColor flatWhiteColor];
    userImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.userView addSubview:userImageView];
    self.userImageView = userImageView;
    
    UILabel *userNameLbl = [[UILabel alloc] init];
    userNameLbl.font = [UIFont systemFontOfSize:13];
    userNameLbl.text = @"我的帐号";
    userNameLbl.textColor = [UIColor whiteColor];
    [self addSubview:userNameLbl];
    self.userNameLbl = userNameLbl;
}
#pragma - mark UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0: {  //打开照相机拍照
            [self takePhoto];
            break;
        }
        case 1: { //打开本地相册
            [self localPhoto];
            break;
        }
        default: {
            break;
        }
    }
}
#pragma - mark UIImagePickDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.userImageView.image = [image imageByRoundCornerRadius:70 borderWidth:0 borderColor:[UIColor whiteColor]];
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}
#pragma - mark private method
- (void) takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [[self viewController] presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
- (void) localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [[self viewController] presentViewController:picker animated:YES completion:nil];
}
// 得到viewController
- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
#pragma mark - setup frame
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _bgImage.frame = self.bounds;
    
    WEAK_SELF(vs);
    
    CGSize userNameSize = [_userNameLbl.text sizeWithAttributes:@{NSFontAttributeName : _userNameLbl.font}];
    
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(vs.mas_top).with.offset(QCDetailViewBorder);
    }];
    
    [_userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(userNameSize);
        make.centerX.equalTo(vs.mas_centerX);
        make.top.equalTo(_userView.mas_bottom).with.offset(QCDetailViewBorder);
    }];
}
@end
