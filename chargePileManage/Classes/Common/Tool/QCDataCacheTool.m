//
//  QCDataCacheTool.m
//  chargePileManage
//
//  Created by YuMing on 16/6/20.
//  Copyright © 2016年 shQianChen. All rights reserved.
//

#import "QCDataCacheTool.h"
#import "FMDB.h"

#import "QCPileListNumModel.h"
#import "QCPileListDataMode.h"


@interface QCDataCacheTool ()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@end

@implementation QCDataCacheTool
static FMDatabaseQueue *_queue;
#pragma - mark init db
//+ (void) initialize
//{
//    // 0.获得沙盒中的数据库文件名
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"statuses.sqlite"];
//    // 1.创建队列
//    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
//    // 2.创表
//    [_queue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,access_token text,idstr text,dict blob)"];
//    }];
//}
- (instancetype) initWithDBName:(NSString *)dbName sqlCmd:(NSString *)sqlCmd
{
    self = [super init];
    if (self) {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [docsdir stringByAppendingPathComponent:dbName];
        
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
        [queue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:sqlCmd];
        }];
        [queue close];
    }
    return self;
}

#pragma - mark add db data
//  增加多条字典数据
- (void)addChargePileDatas:(NSString *)dbName sqlCmd:(NSString *)sqlCmd array:(NSArray *)dictArray
{
    for (NSDictionary *dict in dictArray) {
        [self addChargePileData:dbName sqlCmd:sqlCmd dict:dict];
    }
}
- (void)addChargePileData:(NSString *)dbName sqlCmd:(NSString *)sqlCmd dict:(NSDictionary *)dict
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *address   = dict[@"address"];
        NSString *cpNumber  = dict[@"cpNumber"];
        NSData   *data      = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into t_data (address,cpNumber,dict) values(?,?,?)",address,cpNumber,data];
    }];
    [queue close];
}

// 保存充电桩号码
- (void)addChargePileDatas:(NSString *)dbName sqlCmd:(NSString *)sqlCmd cpNumArray:(NSArray *)cpArray
{
    for (QCPileListNumModel *model in cpArray) {
        [self addChargePileData:dbName sqlCmd:sqlCmd chargeNum:model];
    }
}
- (void)addChargePileData:(NSString *)dbName sqlCmd:(NSString *)sqlCmd chargeNum:(QCPileListNumModel *)number
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
#if SERVER_TYPE
        NSString *address   = number.address;
        NSString *cpNumber  = number.chargePileNum;
        [db executeUpdate:@"insert into t_number (address,chargePileNum) values(?,?)",address,cpNumber];
#else
        NSString *price = [NSString stringWithFormat:@"%.2f",number.price];
        NSString *status = [NSString stringWithFormat:@"%d",number.status];
        [db executeUpdate:@"insert into t_number (cpid,cpnm,price,status) values(?,?,?,?)",number.cpid,number.cpnm,(int)price,status];
//    [db executeUpdate:@"insert into t_number (cpid,cpnm) values(?,?)",number.cpid,number.cpnm];

#endif
    }];
    [queue close];
}
// 保存充电桩数据
- (void)addChargePileData:(NSString *)dbName sqlData:(NSString *)sqlCmd cpData:(QCPileListDataMode *)data
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *address   = [NSString stringWithFormat:@"%lld",data.chargePileAddress];
        NSData *cpData = [NSKeyedArchiver archivedDataWithRootObject:data];
        
        [db executeUpdate:@"insert into t_data (address,cpdata) values(?,?)",address,cpData];
    }];
    [queue close];
}

//+ (void)addChargePileDatas:(NSArray *)dictArray
//{
//    for (NSDictionary *dict in dictArray) {
//        [self addChargePileData:dict];
//    }
//}
//+ (void) addChargePileData:(NSDictionary *) dict
//{
//    [_queue inDatabase:^(FMDatabase *db) {
//        // 1.获得需要存储的数据
//        NSString *address   = dict[@"address"];
//        NSString *cpNumber  = dict[@"cpNumber"];
//        NSData   *data      = [NSKeyedArchiver archivedDataWithRootObject:dict];
//        // 2.存储数据
//        [db executeUpdate:@"insert into t_data (address,cpNumber,dict) values(?,?,?)",address,cpNumber,data];
//    }];
//}


#pragma - mark read db data

- (NSArray *)cpDataWithParam:(NSString *)dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_data"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"cpdata"];
            QCPileListDataMode *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    [queue close];
    return statusArray;
}

- (NSArray *)getCPListWithParam:(NSString *)dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_number"];
        while (rs.next) {
            QCPileListNumModel *cpNum = [[QCPileListNumModel alloc] init];
#if SERVER_TYPE
            cpNum.chargePileNum = [rs stringForColumn:@"chargePileNum"];
#else
            cpNum.cpid = [rs stringForColumn:@"cpid"];
            cpNum.cpnm = [rs stringForColumn:@"cpnm"];
            cpNum.price = [[rs stringForColumn:@"price"] floatValue];
            cpNum.status = [[rs stringForColumn:@"status"] intValue];
            
            WQLog(@"cpNum---cpid:%@,cpnm:%@,price:%f,status:%d",cpNum.cpid,cpNum.cpnm,cpNum.price,cpNum.status);
#endif
            
            [statusArray addObject:cpNum];
        }
    }];
    [queue close];
    return statusArray;
}
#pragma - mark store cpid
- (NSArray *)getCPListNumberWithParam:(NSString *)dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_cpid"];
        while (rs.next) {
            [statusArray addObject:[rs stringForColumn:@"cpid"]];
        }
    }];
    [queue close];
    return statusArray;
}
- (void) storeCPListNumberWithParam:(NSString *)dbName chargePileID:(QCPileListNumModel *)number
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [queue inDatabase:^(FMDatabase *db) {
#if SERVER_TYPE
        NSString *address   = number.address;
        NSString *cpNumber  = number.chargePileNum;
        [db executeUpdate:@"insert into t_number (address,chargePileNum) values(?,?)",address,cpNumber];
#else
        [db executeUpdate:@"insert into t_number (cpid) values(?)",number.cpid];
#endif
    }];
    [queue close];
}

@end
