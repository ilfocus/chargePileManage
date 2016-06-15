//
//  QCHistoryRecordCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/6/14.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCHistoryRecordCtrl.h"
#import "QCHistoryRecordCell.h"

@interface QCHistoryRecordCtrl () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UITableView *chargeRecordView;
@property (nonatomic,weak) UITableView *supplyRecordView;
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
    
    UITableView *chargeRecordView = [[UITableView alloc] init];
    chargeRecordView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    chargeRecordView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:chargeRecordView];
    self.chargeRecordView = chargeRecordView;
    self.chargeRecordView.delegate = self;
    self.chargeRecordView.dataSource = self;
    
    UITableView *supplyRecordView = [[UITableView alloc] init];
    supplyRecordView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    supplyRecordView.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:supplyRecordView];
    self.supplyRecordView = supplyRecordView;
    self.supplyRecordView.delegate = self;
    self.supplyRecordView.dataSource = self;
    
}
#pragma mark - UITableViewDateSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCHistoryRecordCell *cell = [QCHistoryRecordCell cellWithTableView:tableView];
    //cell.textLabel.text = @"cell0";
    return cell;
}
#pragma mark - UITableViewDelegate



@end
