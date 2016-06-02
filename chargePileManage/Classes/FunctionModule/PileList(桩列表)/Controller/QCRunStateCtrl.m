//
//  QCRunStateCtrl.m
//  chargePileManage
//
//  Created by YuMing on 16/5/31.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCRunStateCtrl.h"
#import "PNChart.h"
#import "YYKit.h"

@interface QCRunStateCtrl ()
@property (nonatomic,strong) PNLineChart * lineChart;
@end

@implementation QCRunStateCtrl


#pragma mark lazy load

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubView];
}

- (void) setupSubView {
    [self setupPNChart];
}

- (void) setupPNChart
{
    //For Line Chart
//    PNLineChart * lineVolChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    WEAK_SELF(vs);
    CGFloat runStateAndNavigationBarH = STATUS_HEIGHT + self.navigationController.navigationBar.height;
    CGFloat lineChartH = (self.view.height - runStateAndNavigationBarH - 3 * QCDetailViewBorder) / 3;
    
//    UIView *lineVolChartView = [UIView new];
//    lineVolChartView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:lineVolChartView];
//    
//    UIView *lineCurChartView = [UIView new];
//    lineCurChartView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:lineCurChartView];
//    
//    [lineVolChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vs.view.mas_top).with.offset(runStateAndNavigationBarH + QCDetailViewBorder);
//        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
//        make.height.mas_equalTo(lineChartH);
//    }];
//    
//    [lineCurChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineVolChartView.mas_bottom).with.offset(QCDetailViewBorder);
//        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
//        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
//        make.height.mas_equalTo(lineChartH);
//    }];

    //PNLineChart *lineVolChart = [[PNLineChart alloc] init];
    PNLineChart *lineVolChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 200)];
    lineVolChart.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lineVolChart];
    //PNLineChart *lineCurChart = [[PNLineChart alloc] init];
    PNLineChart *lineCurChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 200)];
    lineCurChart.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lineCurChart];
    
    [lineVolChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    // Line Chart No.1
    NSArray *data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineVolChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineVolChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineVolChart.chartData = @[data01, data02];
    [lineVolChart strokeChart];
    lineVolChart.showSmoothLines = YES;
    
    
    [lineCurChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    // Line Chart No.3
    NSArray *data03Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data03 = [PNLineChartData new];
    data03.color = PNFreshGreen;
    data03.itemCount = lineCurChart.xLabels.count;
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [data03Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.4
    NSArray * data04Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data04 = [PNLineChartData new];
    data04.color = PNTwitterColor;
    data04.itemCount = lineCurChart.xLabels.count;
    data04.getData = ^(NSUInteger index) {
        CGFloat yValue = [data04Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineCurChart.chartData = @[data03, data04];
    [lineCurChart strokeChart];
    lineCurChart.showSmoothLines = YES;
    
//    
    [lineVolChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vs.view.mas_top).with.offset(runStateAndNavigationBarH + QCDetailViewBorder);
        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
        make.height.mas_equalTo(lineChartH);
    }];
    
    [lineCurChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineVolChart.mas_bottom).with.offset(QCDetailViewBorder);
        make.left.equalTo(vs.view.mas_left).with.offset(QCDetailViewBorder);
        make.right.equalTo(vs.view.mas_right).with.offset(-QCDetailViewBorder);
        make.height.mas_equalTo(lineChartH);
    }];

    
}

@end
