//
//  SearchViewController.m
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

#import "YLSearchViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface YLSearchViewController ()
@end

@implementation YLSearchViewController
#pragma mark -- 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索";

    //配置searchbar
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"请输入关键字"];

    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;


    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = mySearchBar;



}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {

        return searchResults.count;
    }
    else {
        return self.serchArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //配置两种不同的行背景颜色
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:170/255. green:178/255. blue:190/255. alpha:1.];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = self.serchArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 40;
    }else {
        return 30;
    }
}

#pragma mark -- 搜索结果点击的后的传值逻辑
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.searchDisplayController.searchResultsTableView) {

        //进行了搜索，把搜索选择的结果传出
        [self.delegate searchResultData:searchResults[indexPath.row]];

    }else {

        //如果没有搜索直接点击的某一行....
        [self.delegate searchResultData:self.serchArray[indexPath.row]];
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];
    if (mySearchBar.text.length > 0 && ![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (int i = 0; i < self.serchArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:self.serchArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:self.serchArray[i]];
                NSRange titleResult = [tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [searchResults addObject:self.serchArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:self.serchArray[i]];
                NSRange titleHeadResult = [tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:self.serchArray[i]];
                }
            }
            else {
                NSRange titleResult=[self.serchArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [searchResults addObject:self.serchArray[i]];
                }
            }
        }
    } else if (mySearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (NSString *tempStr in self.serchArray) {
            NSRange titleResult = [tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length > 0) {
                [searchResults addObject:tempStr];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//cell的刷新动画
    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.2 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}

@end
