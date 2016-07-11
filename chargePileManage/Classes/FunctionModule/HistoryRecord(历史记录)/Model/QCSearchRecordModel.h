//
//  QCSearchRecordModel.h
//  chargePileManage
//
//  Created by YuMing on 16/7/11.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCSearchRecordModel : NSObject
@property (nonatomic,copy) NSString *searchType;
@property (nonatomic,copy) NSString *beginTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *searchWord;
@end
