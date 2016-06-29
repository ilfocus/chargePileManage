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

#import "SVSegmentedControl.h"
// third lib
#import "MJExtension.h"
#import "MJRefresh.h"
#import "QCChiBaoZiHeader.h"
//#import "MJChiBaoZiFooter.h"
#import "QCChiBaoZiFooter.h"
#import "YLSearchViewController.h"


@interface QCHistoryRecordCtrl () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SearchResultDelegate>
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
    // Do any additional setup after loading the view.
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
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
}
#pragma - mark lazy load
- (NSMutableArray *)chargeRecordDataArray
{
    if (_chargeRecordDataArray != nil) {
        _chargeRecordDataArray = [NSMutableArray array];
    }
    return _chargeRecordDataArray;
}
- (NSMutableArray *) supplyRecordDataArray
{
    if (_supplyRecordDataArray != nil) {
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
    WQLog(@"---loadChargeRecordData---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chargeRecordView.mj_header endRefreshing];
        WQLog(@"---self.chargeRecordView.mj_header---");
    });
}

- (void) loadMoreCPData
{
    WQLog(@"---loadChargeRecordData---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.chargeRecordView.mj_footer endRefreshing];
        WQLog(@"---self.chargeRecordView.mj_header---");
    });
}

- (void) loadSupplyRecordData
{
    WQLog(@"---loadSupplyRecordData---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.supplyRecordView.mj_header endRefreshing];
        WQLog(@"---self.supplyRecordView.mj_header---");
    });
}
- (void) loadMoreSRData
{
    WQLog(@"---loadMoreSRData---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.supplyRecordView.mj_footer endRefreshing];
        WQLog(@"---loadMoreSRData---");
    });
}

#pragma mark - private method


- (void) addNewItem:(UIBarButtonItem *)btn
{
    NSLog(@"点击UIBarButtonItem!!!");
    YLSearchViewController *vc = [[YLSearchViewController alloc] initWithNibName:@"YLSearchViewController" bundle:nil];
    //把搜索数据传过去
    vc.serchArray = [NSMutableArray arrayWithObjects:@"你好！code4App",@"I love code",@"Hello world",@"乔布斯",@"code4App",@"愿你开心", nil];
    //设置代理
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
        return 10;
    } else  {
        return 20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _chargeRecordView) {
        QCChargeRecordCell *cell = [QCChargeRecordCell cellWithTableView:tableView];
        return cell;
    } else  {
        QCSupplyRecordCell *cell = [QCSupplyRecordCell cellWithTableView:tableView];
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

@end
