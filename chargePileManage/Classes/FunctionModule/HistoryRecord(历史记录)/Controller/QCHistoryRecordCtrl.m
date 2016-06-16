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


@interface QCHistoryRecordCtrl () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UITableView *chargeRecordView;
@property (nonatomic,weak) UITableView *supplyRecordView;

@property (nonatomic,weak) UISegmentedControl *segmentedView;

@end

@implementation QCHistoryRecordCtrl

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
    //scrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    CGFloat segmentedHeight = 40;
    NSArray *array=@[@"充电记录",@"供电记录"];
    UISegmentedControl *segmentedView = [[UISegmentedControl alloc] initWithItems:array];
    segmentedView.selectedSegmentIndex = 0;
    
    [segmentedView addTarget:self action:@selector(charge:) forControlEvents:UIControlEventValueChanged];
    segmentedView.frame = CGRectMake(0, 64, SCREEN_WIDTH, segmentedHeight);;
    [self.view addSubview:segmentedView];
    self.segmentedView = segmentedView;
    
    
    CGRect chargeRecordViewFrame = CGRectMake(0, 64 + segmentedHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITableView *chargeRecordView = [[UITableView alloc] initWithFrame:chargeRecordViewFrame style:UITableViewStylePlain];
    chargeRecordView.rowHeight = 100;
    [_scrollView addSubview:chargeRecordView];
    self.chargeRecordView = chargeRecordView;
    self.chargeRecordView.delegate = self;
    self.chargeRecordView.dataSource = self;
    
    CGRect supplyRecordViewFrame = CGRectMake(SCREEN_WIDTH, 64 + segmentedHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITableView *supplyRecordView = [[UITableView alloc] initWithFrame:supplyRecordViewFrame style:UITableViewStylePlain];
    supplyRecordView.rowHeight = 100;
    [_scrollView addSubview:supplyRecordView];
    self.supplyRecordView = supplyRecordView;
    self.supplyRecordView.delegate = self;
    self.supplyRecordView.dataSource = self;
    
}

#pragma mark - private method
- (void) charge:(UISegmentedControl *)segmented
{
    if (segmented.selectedSegmentIndex == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
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
    //NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    if (scrollView.contentOffset.x < SCREEN_WIDTH / 2) {
        _segmentedView.selectedSegmentIndex = 0;
    } else {
        _segmentedView.selectedSegmentIndex = 1;
    }
}

@end
