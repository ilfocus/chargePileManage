//
//  UIScrollView+ScalableCover.h
//  ScalableCover
//
//  Created by AeternChan on 7/20/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat MaxHeight = 200;


@interface ScalableCover : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;

@end




@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image;
- (void)removeScalableCover;

@end

