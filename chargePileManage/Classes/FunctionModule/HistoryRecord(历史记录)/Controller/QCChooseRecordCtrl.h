//
//  QCChooseRecordCtrl.h
//  chargePileManage
//
//  Created by YuMing on 16/7/8.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCSearchRecordModel;
// 实现代理
@protocol QCChooseRecordCtrlDelegate <NSObject>

@optional
- (void) searchRecord:(QCSearchRecordModel *)searchModel;

@end


@interface QCChooseRecordCtrl : UIViewController
@property (nonatomic,weak) id<QCChooseRecordCtrlDelegate> delegate;
@end
