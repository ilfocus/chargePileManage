//
//  QCHistoryRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCHistoryRecordCtrl.h"
#import "QCChargeRecordCell.h"
#import "QCSupplyRecordCell.h"
#import "UIColor+hex.h"
#import "QCSearchRecordCtrl.h"
#import "QCChooseRecordCtrl.h"
#import "QCSearchRecordModel.h"
// model
#import "QCChargeRecordModel.h"
#import "QCSupplyRecordModel.h"

// third lib
#import "SVSegmentedControl.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "QCChiBaoZiHeader.h"
#import "QCChiBaoZiFooter.h"
#import "YLSearchViewController.h"
#import "YYKit.h"
// DB
#import "QCDataCacheTool.h"
// http
#import "QCHttpTool.h"



@interface QCHistoryRecordCtrl () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SearchResultDelegate,QCChooseRecordCtrlDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UITableView *chargeRecordView;
@property (nonatomic,weak) UITableView *supplyRecordView;
@property (nonatomic,weak) UISegmentedControl *segmentedView;
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic,strong) NSMutableArray *chargeRecordDataArray;
@property (nonatomic,strong) NSMutableArray *supplyRecordDataArray;
@end

@implementation QCHistoryRecordCtrl

#pragma - mark initView
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WQColor(226,226,226);
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2,0);
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    CGFloat segmentedHeight = 40;
    CGFloat segmentedY = 64;
    NSArray *array = @[@"充电记录",@"供电记录"];
    UISegmentedControl *segmentedView = [[UISegmentedControl alloc] initWithItems:array];
    segmentedView.selectedSegmentIndex = 0;
    segmentedView.tintColor = [UIColor colorWithHex:0x15A230];
    [segmentedView addTarget:self action:@selector(charge:) forControlEvents:UIControlEventValueChanged];
    segmentedView.frame = CGRectMake(0, segmentedY, SCREEN_WIDTH, segmentedHeight);;
    [self.view addSubview:segmentedView];
    self.segmentedView = segmentedView;
    
    CGFloat tableViewY = segmentedY + segmentedHeight;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY;
    CGRect chargeRecordViewFrame = CGRectMake(0, tableViewY, SCREEN_WIDTH, tableViewH);
    UITableView *chargeRecordView = [[UITableView alloc] initWithFrame:chargeRecordViewFrame style:UITableViewStyleGrouped];
    chargeRecordView.rowHeight = 90;
    
    UIView *chargeHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    chargeRecordView.tableHeaderView = chargeHeaderView;
    chargeRecordView.tableFooterView = chargeHeaderView;
    [_scrollView addSubview:chargeRecordView];
    self.chargeRecordView = chargeRecordView;
    self.chargeRecordView.delegate = self;
    self.chargeRecordView.dataSource = self;
    
    CGRect supplyRecordViewFrame = CGRectMake(SCREEN_WIDTH, tableViewY, SCREEN_WIDTH, tableViewH);
    UITableView *supplyRecordView = [[UITableView alloc] initWithFrame:supplyRecordViewFrame style:UITableViewStyleGrouped];
    supplyRecordView.rowHeight = 90;
    UIView *supplyHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    supplyRecordView.tableHeaderView = supplyHeaderView;
    supplyRecordView.tableFooterView = supplyHeaderView;
    [_scrollView addSubview:supplyRecordView];
    self.supplyRecordView = supplyRecordView;
    self.supplyRecordView.delegate = self;
    self.supplyRecordView.dataSource = self;
    
    
    UIBarButtonItem *uibtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addNewItem:)];
    self.navigationItem.rightBarButtonItem  = uibtn;
    
    
    QCChiBaoZiHeader *chargeRecordheader = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadChargeRecordData)];
    self.chargeRecordView.mj_header = chargeRecordheader;
    
    self.chargeRecordView.mj_footer = [QCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCPData)];
    
    self.chargeRecordView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    QCChiBaoZiHeader *supplyRecordheader = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadSupplyRecordData)];
    self.supplyRecordView.mj_header = supplyRecordheader;
    self.supplyRecordView.mj_footer = [QCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSRData)];
    self.supplyRecordView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    // 加载20条数据库中充电数据
    // 验证成功后，把数据存入数据库中
    NSString *dbName = @"chargePileData.sqlite";
    NSString *chargeRecordCmd = @"CREATE TABLE IF NOT EXISTS t_chargeRecord (id integer PRIMARY KEY AUTOINCREMENT,chargeNum text,time text,cost text)";
    QCDataCacheTool *chargeRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:chargeRecordCmd];
    NSArray *chargeRecordArr = [chargeRecordCache getChargeRecordData:dbName];
    if (chargeRecordArr) {
        //
    }
    // 加载20条数据库中用户信息
    NSString *supplyRecordCmd = @"CREATE TABLE IF NOT EXISTS t_supplyRecord (id integer PRIMARY KEY AUTOINCREMENT,userID text,time text,cost text)";
    QCDataCacheTool *supplyRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:supplyRecordCmd];
    NSArray *supplyRecordArr = [supplyRecordCache getSupplyRecordData:dbName];
    if (supplyRecordArr) {
        //
    }
}
#pragma - mark lazy load
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


#pragma mark -- SearchResultDelegate

- (void)searchResultData:(NSString *)value {

    WQLog(@"搜索---%@",value);
}

#pragma - mark mjRefresh Data
- (void) loadChargeRecordData
{
    // 网络加载最新的充电记录
    
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
                [self.chargeRecordView reloadData];
                [self.chargeRecordView.mj_header endRefreshing];
            });
            
        } else {
            
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//    });
}

- (void) loadMoreCPData
{
    // 从本地数据库加载历史充电记录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chargeRecordView.mj_footer endRefreshing];
        
    });
}

- (void) loadSupplyRecordData
{
    // 从网络加载最新的供电记录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"cpuserid"] = @"U001";
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
                QCSupplyRecordModel *model = [QCSupplyRecordModel new];
                model.userID = dict[@"cpUserId"];
                model.chargeElectDate = dict[@"endTime"];
                model.supplyElectCost = [dict[@"totalFee"] floatValue];
                WQLog(@"---cpUserId---%@",dict[@"cpUserId"]);
                WQLog(@"---beginTime---%@",dict[@"beginTime"]);
                WQLog(@"---endTime---%@",dict[@"endTime"]);
                WQLog(@"---totalFee---%@",dict[@"totalFee"]);
                [self.supplyRecordDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.supplyRecordView reloadData];
                [self.supplyRecordView.mj_header endRefreshing];
            });
        } else {
            
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
    }];
}
- (void) loadMoreSRData
{
    // 从本地数据库加载历史供电记录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.supplyRecordView.mj_footer endRefreshing];
    });
}

#pragma mark - private method


- (void) addNewItem:(UIBarButtonItem *)btn
{
    QCChooseRecordCtrl *vc = [[QCChooseRecordCtrl alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"搜索";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) charge:(UISegmentedControl *)segmented
{
    WQLog(@"scrollView---charge");
    if (segmented.selectedSegmentIndex == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _searchBar.placeholder = @"桩号查询";
    } else {
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        _searchBar.placeholder = @"用户查询";
    }
    _scrollView.bouncesZoom = NO;

}

#pragma mark - UITableViewDateSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _chargeRecordView) {
        return _chargeRecordDataArray.count;
    } else  {
        return _supplyRecordDataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _chargeRecordView) {
        WQLog(@"_chargeRecordView---refresh");
        QCChargeRecordCell *cell = [QCChargeRecordCell cellWithTableView:tableView];
        cell.cpRecord = self.chargeRecordDataArray[indexPath.row];
//        QCChargeRecordModel *model = [QCChargeRecordModel new];
//        model.cpID = @"001";
//        model.chargeElectDate = @"20160707";
//        model.chargeElectCost = 20.65;
//        cell.cpRecord = model;
        return cell;
    } else  {
        WQLog(@"supplyRecordView---refresh");
        QCSupplyRecordCell *cell = [QCSupplyRecordCell cellWithTableView:tableView];
        cell.cpSupplyRecord = self.supplyRecordDataArray[indexPath.row];
        return cell;
    }
}
#pragma mark - UITableViewDelegate

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //WQLog(@"scrollView.contentOffset---%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        //WQLog(@"是scrollView---%@",scrollView);
        if (scrollView.contentOffset.x < SCREEN_WIDTH / 2) {
            _segmentedView.selectedSegmentIndex = 0;
            //_searchBar.placeholder = @"桩号查询";
        } else {
            _segmentedView.selectedSegmentIndex = 1;
            //_searchBar.placeholder = @"用户查询";
        }
    } else {
//        WQLog(@"不是scrollView---%@",scrollView);
    }
}
#pragma - mark sets and gets
#pragma - mark QCChooseRecordDelegate
- (void)searchRecord:(QCSearchRecordModel *)searchModel
{
    WQLog(@"%s",__func__);
    WQLog(@"searchModel.searchType---%@",searchModel.searchType);
    WQLog(@"searchModel.beginTime---%@",searchModel.beginTime);
    WQLog(@"searchModel.endTime---%@",searchModel.endTime);
    WQLog(@"searchModel.searchWord---%@",searchModel.searchWord);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ([searchModel.searchType isEqualToString:@"充电记录"]) {
        params[@"cpid"] = @([searchModel.searchWord intValue]);
        params[@"from"] = searchModel.beginTime;
        params[@"to"] = searchModel.endTime;
        
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
                    [self.chargeRecordView reloadData];
                    [self.chargeRecordView.mj_header endRefreshing];
                });
                
            } else {
                
            }
        } failure:^(NSError *error) {
            WQLog(@"%@",error);
        }];
        
    } else {
        
        self.segmentedView.selectedSegmentIndex = 1;
        [self charge:self.segmentedView];
        
        params[@"cpuserid"] = searchModel.searchWord;
        
        params[@"from"] = searchModel.beginTime;
        params[@"to"] = searchModel.endTime;
        
        NSString *ulrString = [NSString stringWithFormat:@"%@%@",CPMAPI_PREFIX,CPMAPI_HISTORY_INFO];
        
        [QCHttpTool httpQueryData:ulrString params:params success:^(id json) {
            // parse the data returned by the server
            NSString *errorCode = json[@"errorCode"];
            
            WQLog(@"---json---%@",json);
            
            if (![errorCode isNotBlank]) {
                
                NSArray *userArr = json[@"detail"];
                for (NSDictionary *dict in userArr) {
                    QCSupplyRecordModel *model = [QCSupplyRecordModel new];
                    model.userID = dict[@"cpUserId"];
                    model.chargeElectDate = dict[@"endTime"];
                    model.supplyElectCost = [dict[@"totalFee"] floatValue];
                    WQLog(@"---cpUserId---%@",dict[@"cpUserId"]);
                    WQLog(@"---beginTime---%@",dict[@"beginTime"]);
                    WQLog(@"---endTime---%@",dict[@"endTime"]);
                    WQLog(@"---totalFee---%@",dict[@"totalFee"]);
                    [self.supplyRecordDataArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.supplyRecordView reloadData];
                    [self.supplyRecordView.mj_header endRefreshing];
                });
            } else {
                
            }
        } failure:^(NSError *error) {
            WQLog(@"%@",error);
        }];
    }
    
    
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WQLog(@"%s",__func__);
}
@end
