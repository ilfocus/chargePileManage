//
//  QCSearchRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/7/7.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCSearchRecordCtrl.h"

#import "QCChargeRecordCell.h"
#import "QCSupplyRecordCell.h"
#import "QCChargeRecordModel.h"
#import "QCSupplyRecordModel.h"

#import "QCHttpTool.h"
#import "YYKit.h"

@interface QCSearchRecordCtrl() <UISearchBarDelegate>
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;

@property (nonatomic,strong) NSMutableArray *chargeRecordDataArray;
@property (nonatomic,strong) NSMutableArray *supplyRecordDataArray;
@end
@implementation QCSearchRecordCtrl
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSearchBar];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setTitle:@"设置" forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 40, 40);
    [searchBtn addTarget:self action:@selector(setSearch) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *uibtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(setSearch:)];
    UIBarButtonItem *uiBtn = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem  = uiBtn;
    
    
    self.tableView.rowHeight = 90;
}

#pragma - mark method private
- (void) setSearch {
    WQLog(@"点击设置");
    
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    
    UIView *backView = [[UIView alloc] initWithFrame:window.bounds];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [
     window addSubview:backView];
    
    
    UIView *setCondition = [[UIView alloc] init];
    
    setCondition.backgroundColor = [UIColor whiteColor];
    
    CGFloat setConditionY = self.navigationController.navigationBar.frame.size.height + 20;
    
    setCondition.frame = CGRectMake(0, setConditionY, SCREEN_WIDTH, 100);
    [backView addSubview:setCondition];
}


#pragma - mark initUI
- (void)setSearchBar
{
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    searchBar.translucent = YES;
    searchBar.barStyle = UIBarStyleDefault;
    [searchBar sizeToFit];
//    [searchBar becomeFirstResponder];
    searchBar.delegate = self;
    [self.tableView setTableHeaderView:searchBar];
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    // searchResultsDataSource 就是 UITableViewDataSource
    _searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    _searchDisplayController.searchResultsDelegate = self;
}

#pragma - mark UITableViewDateSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return 1;
    }
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return 10;
    }
    return 10;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView) {
        //
    }
    
    QCChargeRecordCell *cell = [QCChargeRecordCell cellWithTableView:tableView];
    return cell;
}

#pragma - mark UISearchBarDelegate
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    WQLog(@"点击搜索按钮！！！");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"cpid"] = @3;
    params[@"from"] = @"20160101";
    params[@"to"] = @"20160701";
    
    NSString *ulrString = [NSString stringWithFormat:@"%@%@",CPMAPI_PREFIX,CPMAPI_HISTORY_INFO];
    
    [QCHttpTool httpQueryData:ulrString params:params success:^(id json) {
        // parse the data returned by the server
        NSString *errorCode = json[@"errorCode"];
        
        WQLog(@"---json---%@",json);
        
        if (![errorCode isNotBlank]) {
            
            NSArray *userArr = json[@"detail"];
            for (NSDictionary *dict in userArr) {
                QCChargeRecordModel *cpModel = [QCChargeRecordModel new];
                cpModel.cpID = dict[@"cpId"];
                cpModel.chargeElectDate = dict[@"endTime"];
                cpModel.chargeElectCost = [dict[@"totalFee"] floatValue];
                
                WQLog(@"---cpId---%@",dict[@"cpId"]);
                WQLog(@"---beginTime---%@",dict[@"beginTime"]);
                WQLog(@"---endTime---%@",dict[@"endTime"]);
                WQLog(@"---totalFee---%@",dict[@"totalFee"]);
                
                [self.chargeRecordDataArray addObject:cpModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } else {
            
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
    }];
}
#pragma - mark LAZY_LOAD
- (NSMutableArray *)chargeRecordDataArray
{
    if (_chargeRecordDataArray == nil) {
        _chargeRecordDataArray = [NSMutableArray array];
    }
    return _chargeRecordDataArray;
}
- (NSMutableArray *) supplyRecordDataArray
{
    if (_supplyRecordDataArray == nil) {
        _supplyRecordDataArray = [NSMutableArray array];
    }
    return _supplyRecordDataArray;
}
@end
