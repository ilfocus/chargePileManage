//
//  WQBaseTableViewController.h
//  MessageGroups
//
//  Created by YuMing on 16/3/28.
//  Copyright © 2016年 JAsolar. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class WQBaseTableViewController;

//@protocol WQBaseTableViewDelegate <NSObject>
//
////@optional
//
//- (void)baseTableView:(WQBaseTableViewController *)baseTableView msgInfoArray:(NSArray *)msgInfoArray;
//
//@end


@interface WQBaseTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *data;

//@property (nonatomic,weak) id<WQBaseTableViewDelegate> delegate;
@end
