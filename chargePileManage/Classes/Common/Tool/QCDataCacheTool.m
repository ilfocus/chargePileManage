//
//  QCDataCacheTool.m
//  chargePileManage
//
//  Created by YuMing on 16/6/20.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCDataCacheTool.h"

#import "FMDB.h"

@implementation QCDataCacheTool
static FMDatabaseQueue *_queue;

+ (void) initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"chargePileData.sqlite"];
    // 创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 创建表格
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_data (id integer primary key autoincrement,address text,cpNumber text,dict blob)"];
    }];
}


//- (instancetype) initWithDBName:()

+ (void)addChargePileDatas:(NSArray *)dictArray
{
    for (NSDictionary *dict in dictArray) {
        [self addChargePileData:dict];
    }
}

+ (void)addChargePileData:(NSDictionary *)dict
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *address   = dict[@"address"];
        NSString *cpNumber  = dict[@"cpNumber"];
        NSData   *data      = [NSKeyedArchiver archivedDataWithRootObject:dict];
        // 2.存储数据
        [db executeUpdate:@"insert into t_data (address,cpNumber,dict) values(?,?,?)",address,cpNumber,data];
    }];
}
@end
