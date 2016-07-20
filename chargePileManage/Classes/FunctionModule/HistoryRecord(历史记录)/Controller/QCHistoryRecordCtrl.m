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
#import "QCFaultRecordCell.h"
#import "UIColor+hex.h"
#import "QCSearchRecordCtrl.h"
#import "QCChooseRecordCtrl.h"
#import "QCSearchRecordModel.h"
// model
#import "QCChargeRecordModel.h"
#import "QCSupplyRecordModel.h"
#import "QCFaultRecordModel.h"

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



@interface QCHistoryRecordCtrl () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,QCChooseRecordCtrlDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UITableView *chargeRecordView;
@property (nonatomic,weak) UITableView *supplyRecordView;
@property (nonatomic,weak) UITableView *faultRecordView;
@property (nonatomic,weak) UISegmentedControl *segmentedView;
//@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic,strong) NSMutableArray *chargeRecordDataArray;
@property (nonatomic,strong) NSMutableArray *supplyRecordDataArray;
@property (nonatomic,strong) NSMutableArray *faultRecordDataArray;
@end

@implementation QCHistoryRecordCtrl

#pragma - mark initView
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSelfView];
    [self setupScrollView];
    [self setupSegAndTableView];
    [self setupBarItem];
    [self setupRefrshControl];
    [self setupDataFromDB];
}
#pragma - mark setupSubViews
- (void) setupSelfView
{
    self.view.backgroundColor = WQColor(226,226,226);
}
- (void) setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;// 不去自动调整
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3,0);
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
}
- (void) setupSegAndTableView
{
    CGFloat segmentedHeight = 40;
    CGFloat segmentedY = 64;
    
    NSArray *array = @[@"充电记录",@"用户记录",@"故障记录"];
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
    
    CGRect FaultRecordViewFrame = CGRectMake(SCREEN_WIDTH * 2, tableViewY, SCREEN_WIDTH, tableViewH);
    UITableView *faultRecordView = [[UITableView alloc] initWithFrame:FaultRecordViewFrame style:UITableViewStyleGrouped];
//    faultRecordView.backgroundColor = [UIColor redColor];
    faultRecordView.rowHeight = 90;
    UIView *faultHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    faultRecordView.tableHeaderView = faultHeaderView;
    faultRecordView.tableFooterView = faultHeaderView;
    [_scrollView addSubview:faultRecordView];
    self.faultRecordView = faultRecordView;
    self.faultRecordView.delegate = self;
    self.faultRecordView.dataSource = self;
}
- (void) setupBarItem
{
    UIBarButtonItem *uibtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addNewItem:)];
    self.navigationItem.rightBarButtonItem  = uibtn;
}
- (void) setupRefrshControl
{
    QCChiBaoZiHeader *chargeRecordheader = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadChargeRecordData)];
    self.chargeRecordView.mj_header = chargeRecordheader;
    
    self.chargeRecordView.mj_footer = [QCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCPData)];
    
    self.chargeRecordView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    QCChiBaoZiHeader *supplyRecordheader = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadSupplyRecordData)];
    self.supplyRecordView.mj_header = supplyRecordheader;
    self.supplyRecordView.mj_footer = [QCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSRData)];
    self.supplyRecordView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    QCChiBaoZiHeader *faultRecordheader = [QCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFaultRecordData)];
    self.faultRecordView.mj_header = faultRecordheader;
    self.faultRecordView.mj_footer = [QCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFRData)];
    self.faultRecordView.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
}
- (void) setupDataFromDB
{
    // 加载20条数据库中充电数据
    // 验证成功后，把数据存入数据库中
    NSString *dbName = @"chargePileData.sqlite";
    NSString *chargeRecordCmd = @"CREATE TABLE IF NOT EXISTS t_chargeRecord (id integer PRIMARY KEY AUTOINCREMENT,chargeNum text,time text,cost text)";
    QCDataCacheTool *chargeRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:chargeRecordCmd];
    NSArray *chargeRecordArr = [chargeRecordCache getChargeRecordData:dbName];
    if (chargeRecordArr) {
        //
        self.chargeRecordDataArray = [chargeRecordArr mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.chargeRecordView reloadData];
        });
    }
    // 加载20条数据库中用户信息
    NSString *supplyRecordCmd = @"CREATE TABLE IF NOT EXISTS t_supplyRecord (id integer PRIMARY KEY AUTOINCREMENT,userID text,time text,cost text)";
    QCDataCacheTool *supplyRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:supplyRecordCmd];
    NSArray *supplyRecordArr = [supplyRecordCache getSupplyRecordData:dbName];
    if (supplyRecordArr) {
        self.supplyRecordDataArray = [supplyRecordArr mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.supplyRecordView reloadData];
        });
    }
    
    // 加载数据库中故障信息
    NSString *faultRecordCmd = @"CREATE TABLE IF NOT EXISTS t_faultRecord (id integer PRIMARY KEY AUTOINCREMENT,cpID text,happentime text,cpInOverCur text,cpInOverVol text,cpInUnderCur text,cpInUnderVol text,cpOutOverCur text,cpOutOverVol text,cpOutUnderCur text,cpOutUnderVol text,cpTempHigh text,cpOutShort text)";
    QCDataCacheTool *faultRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:faultRecordCmd];
    NSArray *faultRecordArr = [faultRecordCache getFaultRecordData:dbName];
    if (faultRecordArr) {
        self.faultRecordDataArray = [faultRecordArr mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.faultRecordView reloadData];
        });
    }
}
#pragma - mark mjRefresh Data
// 加载网络数据
- (void) loadChargeRecordData
{
    // DB
    NSString *dbName = @"chargePileData.sqlite";
    NSString *chargeRecordCmd = @"CREATE TABLE IF NOT EXISTS t_chargeRecord (id integer PRIMARY KEY AUTOINCREMENT,chargeNum text,time text,cost text)";
    QCDataCacheTool *chargeRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:chargeRecordCmd];
    
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
                [chargeRecordCache addChargeRecordData:dbName cpData:cpModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.chargeRecordView reloadData];
                [self.chargeRecordView.mj_header endRefreshing];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.chargeRecordView.mj_header endRefreshing];
            });
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.chargeRecordView.mj_header endRefreshing];
        });
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
    // 设置数据库
    NSString *dbName = @"chargePileData.sqlite";
    NSString *supplyRecordCmd = @"CREATE TABLE IF NOT EXISTS t_supplyRecord (id integer PRIMARY KEY AUTOINCREMENT,userID text,time text,cost text)";
    QCDataCacheTool *supplyRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:supplyRecordCmd];
    
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
                [supplyRecordCache addSupplyRecordData:dbName cpData:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.supplyRecordView reloadData];
                [self.supplyRecordView.mj_header endRefreshing];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.supplyRecordView.mj_header endRefreshing];
            });
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.supplyRecordView.mj_header endRefreshing];
        });
    }];
}
- (void) loadMoreSRData
{
    // 从本地数据库加载历史供电记录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.supplyRecordView.mj_footer endRefreshing];
    });
}
- (void) loadFaultRecordData
{
    // 设置数据库
    NSString *dbName = @"chargePileData.sqlite";
    NSString *faultRecordCmd = @"CREATE TABLE IF NOT EXISTS t_faultRecord (id integer PRIMARY KEY AUTOINCREMENT,cpID text,happentime text,cpInOverCur text,cpInOverVol text,cpInUnderCur text,cpInUnderVol text,cpOutOverCur text,cpOutOverVol text,cpOutUnderCur text,cpOutUnderVol text,cpTempHigh text,cpOutShort text)";
    QCDataCacheTool *faultRecordCache = [[QCDataCacheTool alloc] initWithDBName:dbName sqlCmd:faultRecordCmd];
    
    // 从网络加载最新的供电记录
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"cpid"] = @"1";
    params[@"from"] = @"20160101";
    params[@"to"] = @"20160718";
    
    NSString *ulrString = [NSString stringWithFormat:@"%@%@",@"http://192.168.8.132:8080/cpserver/",CPMAPI_FAULT_HISTORY];
    
    [QCHttpTool httpQueryData:ulrString params:params success:^(id json) {
        // parse the data returned by the server
        NSString *errorCode = json[@"errorCode"];
        
        if (![errorCode isNotBlank]) {
            
            NSArray *userArr = json[@"detail"];
            for (NSDictionary *dict in userArr) {
                
                QCFaultRecordModel *model = [QCFaultRecordModel new];
                
                model.cpID = dict[@"cpid"];
                model.chargeElectDate = dict[@"happentime"];
                model.cpInOverCur = [dict[@"cpInOverCur"] boolValue];
                model.cpInOverVol = [dict[@"cpInOverVol"] boolValue];
                model.cpInUnderCur = [dict[@"cpInUnderCur"] boolValue];
                model.cpInUnderVol = [dict[@"cpInUnderVol"] boolValue];
                
                model.cpOutOverCur = [dict[@"cpOutOverCur"] boolValue];
                model.cpOutOverVol = [dict[@"cpOutOverVol"] boolValue];
                model.cpOutUnderCur = [dict[@"cpOutUnderCur"] boolValue];
                model.cpOutUnderVol = [dict[@"cpOutUnderVol"] boolValue];
                
                model.cpTempHigh = [dict[@"cpTempHigh"] boolValue];
                model.cpOutShort = [dict[@"cpOutShort"] boolValue];
                WQLog(@"------------fault begin -------------------");
                WQLog(@"---cpInOverCur---%@",dict[@"cpInOverCur"]);
                WQLog(@"---cpInOverVol---%@",dict[@"cpInOverVol"]);
                WQLog(@"---cpInUnderCur---%@",dict[@"cpInUnderCur"]);
                WQLog(@"---cpInUnderVol---%@",dict[@"cpInUnderVol"]);
                
                WQLog(@"---cpOutOverCur---%@",dict[@"cpOutOverCur"]);
                WQLog(@"---cpOutOverVol---%@",dict[@"cpOutOverVol"]);
                WQLog(@"---cpOutUnderCur---%@",dict[@"cpOutUnderCur"]);
                WQLog(@"---cpOutUnderVol---%@",dict[@"cpOutUnderVol"]);
                
                WQLog(@"---cpTempHigh---%@",dict[@"cpTempHigh"]);
                WQLog(@"---cpOutShort---%@",dict[@"cpOutShort"]);
                WQLog(@"------------fault end -------------------");
                
                [self.faultRecordDataArray addObject:model];
                [faultRecordCache addFaultRecordData:dbName cpData:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.faultRecordView reloadData];
                [self.faultRecordView.mj_header endRefreshing];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.faultRecordView.mj_header endRefreshing];
            });
        }
    } failure:^(NSError *error) {
        WQLog(@"%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.faultRecordView.mj_header endRefreshing];
        });
    }];
}
- (void) loadMoreFRData
{
    // 从本地数据库加载历史供电记录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.faultRecordView.mj_footer endRefreshing];
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
    if (segmented.selectedSegmentIndex == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (segmented.selectedSegmentIndex == 1) {
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0) animated:YES];
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
    } else  if (tableView == _supplyRecordView) {
        return _supplyRecordDataArray.count;
    } else {
        return _faultRecordDataArray.count;
        //return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _chargeRecordView) {
        QCChargeRecordCell *cell = [QCChargeRecordCell cellWithTableView:tableView];
        cell.cpRecord = self.chargeRecordDataArray[indexPath.row];
        return cell;
    } else if (tableView == _supplyRecordView) {
        QCSupplyRecordCell *cell = [QCSupplyRecordCell cellWithTableView:tableView];
        cell.cpSupplyRecord = self.supplyRecordDataArray[indexPath.row];
        return cell;
    } else {
        QCFaultRecordCell *cell = [QCFaultRecordCell cellWithTableView:tableView];
        cell.faultRecordModel = self.faultRecordDataArray[indexPath.row];
        return cell;
    }
}
#pragma mark - UITableViewDelegate

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        if (scrollView.contentOffset.x < SCREEN_WIDTH / 2) {
            _segmentedView.selectedSegmentIndex = 0;
        } else if ( scrollView.contentOffset.x >= SCREEN_WIDTH / 2
                   && scrollView.contentOffset.x < SCREEN_WIDTH * 3 / 2) {
            _segmentedView.selectedSegmentIndex = 1;
        } else {
            _segmentedView.selectedSegmentIndex = 2;
        }
    } else {
    }
}
#pragma - mark sets and gets
- (NSMutableArray *) chargeRecordDataArray
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
- (NSMutableArray *) faultRecordDataArray
{
    if (_faultRecordDataArray == nil) {
        _faultRecordDataArray = [NSMutableArray array];
    }
    return _faultRecordDataArray;
}
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
        
    } else if ([searchModel.searchType isEqualToString:@"用户记录"]) {
        
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
    } else {
        self.segmentedView.selectedSegmentIndex = 2;
        [self charge:self.segmentedView];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"cpid"] = searchModel.searchWord;
        //    params[@"datacnt"] = @10;
        params[@"from"] = searchModel.beginTime;
        params[@"to"] = searchModel.endTime;
        
        NSString *ulrString = [NSString stringWithFormat:@"%@%@",@"http://192.168.8.132:8080/cpserver/",CPMAPI_FAULT_HISTORY];
        
        [QCHttpTool httpQueryData:ulrString params:params success:^(id json) {
            // parse the data returned by the server
            NSString *errorCode = json[@"errorCode"];
            
            if (![errorCode isNotBlank]) {
                
                NSArray *userArr = json[@"detail"];
                for (NSDictionary *dict in userArr) {
                    
                    QCFaultRecordModel *model = [QCFaultRecordModel new];
                    
                    model.cpID = dict[@"cpid"];
                    model.chargeElectDate = dict[@"happentime"];
                    //                model.supplyElectCost = [dict[@"totalFee"] floatValue];
                    model.cpInOverCur = [dict[@"cpInOverCur"] boolValue];
                    model.cpInOverVol = [dict[@"cpInOverVol"] boolValue];
                    model.cpInUnderCur = [dict[@"cpInUnderCur"] boolValue];
                    model.cpInUnderVol = [dict[@"cpInUnderVol"] boolValue];
                    
                    model.cpOutOverCur = [dict[@"cpOutOverCur"] boolValue];
                    model.cpOutOverVol = [dict[@"cpOutOverVol"] boolValue];
                    model.cpOutUnderCur = [dict[@"cpOutUnderCur"] boolValue];
                    model.cpOutUnderVol = [dict[@"cpOutUnderVol"] boolValue];
                    
                    model.cpTempHigh = [dict[@"cpTempHigh"] boolValue];
                    model.cpOutShort = [dict[@"cpOutShort"] boolValue];
                    
                    WQLog(@"---cpInOverCur---%@",dict[@"cpInOverCur"]);
                    WQLog(@"---cpInOverVol---%@",dict[@"cpInOverVol"]);
                    WQLog(@"---cpInUnderCur---%@",dict[@"cpInUnderCur"]);
                    WQLog(@"---cpInUnderVol---%@",dict[@"cpInUnderVol"]);
                    
                    WQLog(@"---cpOutOverCur---%@",dict[@"cpOutOverCur"]);
                    WQLog(@"---cpOutOverVol---%@",dict[@"cpOutOverVol"]);
                    WQLog(@"---cpOutUnderCur---%@",dict[@"cpOutUnderCur"]);
                    WQLog(@"---cpOutUnderVol---%@",dict[@"cpOutUnderVol"]);
                    
                    WQLog(@"---cpTempHigh---%@",dict[@"cpTempHigh"]);
                    WQLog(@"---cpOutShort---%@",dict[@"cpOutShort"]);
                    
                    
                    [self.faultRecordDataArray addObject:model];
                    //                [supplyRecordCache addSupplyRecordData:dbName cpData:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.faultRecordView reloadData];
                    [self.faultRecordView.mj_header endRefreshing];
                });
            } else {
                
            }
        } failure:^(NSError *error) {
            WQLog(@"%@",error);
        }];
    }
    
    
    
    
    
}
@end
