//
//  SearchViewController.h
//
// QQ:896525689
// Email:zhangyuluios@163.com
//                 _
// /\   /\        | |
// \ \_/ / _   _  | |     _   _
//  \_ _/ | | | | | |    | | | |
//   / \  | |_| | | |__/\| |_| |
//   \_/   \__,_| |_|__,/ \__,_|
//
//  Created by shuogao on 16/6/23.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.

#import <UIKit/UIKit.h>

@protocol SearchResultDelegate <NSObject>

- (void)searchResultData:(NSString *)value;//1.1定义协议与方法


@end


@interface YLSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;

}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *serchArray;
@property (nonatomic,strong) id <SearchResultDelegate> delegate;
@end
