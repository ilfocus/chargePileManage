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
#import "QCPileListUserModel.h"
#import "QCChargeRecordModel.h"
#import "QCSupplyRecordModel.h"


@interface QCDataCacheTool ()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@end

@implementation QCDataCacheTool

static FMDatabaseQueue *_queue;
#pragma - mark init db
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

#pragma - mark add and read CP_DATA
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
#pragma - mark add and read USER_INFO
- (void)addChargePileUser:(NSString *)dbName cpData:(QCPileListUserModel *)data
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        NSData *iconData = [NSKeyedArchiver archivedDataWithRootObject:data.icon];
        [db executeUpdate:@"INSERT INTO t_user (userID,passWord,icon,nickName,sex,permission,area) values(?,?,?,?,?,?,?)",data.userID,data.passWord,iconData,data.nickName,data.sex,data.permission,data.area];
    }];
    [queue close];
}
- (NSArray *)getChargePileUser:(NSString *) dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_user"];
        while (rs.next) {
            QCPileListUserModel *user = [[QCPileListUserModel alloc] init];
            user.userID = [rs stringForColumn:@"userID"];
            user.passWord = [rs stringForColumn:@"passWord"];
            user.icon = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"icon"]];
            user.nickName = [rs stringForColumn:@"nickName"];
            user.sex = [rs stringForColumn:@"sex"];
            user.permission = [rs stringForColumn:@"permission"];
            user.area = [rs stringForColumn:@"area"];
            [statusArray addObject:user];
        }
    }];
    [queue close];
    return statusArray;
}
#pragma - mark add and read CHARGE_RECORD
- (void)addChargeRecordData:(NSString *)dbName cpData:(QCChargeRecordModel *)data
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        NSString *cost = [NSString stringWithFormat:@"%.2f",data.chargeElectCost];
        [db executeUpdate:@"INSERT INTO t_chargeRecord (chargeNum,time,cost) values(?,?,?)",data.cpID,data.chargeElectDate,cost];
    }];
    [queue close];
}

- (NSArray *)getChargeRecordData:(NSString *) dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_chargeRecord"];
        while (rs.next) {
            QCChargeRecordModel *cpRecord = [[QCChargeRecordModel alloc] init];
            cpRecord.cpID = [rs stringForColumn:@"chargeNum"];
            cpRecord.chargeElectDate = [rs stringForColumn:@"time"];
            cpRecord.chargeElectCost = [[rs stringForColumn:@"cost"] floatValue];
            [statusArray addObject:cpRecord];
        }
    }];
    [queue close];
    return statusArray;
}
#pragma - mark add and read SUPPLY_RECORD
- (void)addSupplyRecordData:(NSString *)dbName cpData:(QCSupplyRecordModel *)data
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db) {
        NSString *cost = [NSString stringWithFormat:@"%.2f",data.supplyElectCost];
        [db executeUpdate:@"INSERT INTO t_supplyRecord (userID,time,cost) values(?,?,?)",data.userID,data.chargeElectDate,cost];
    }];
    [queue close];
}

- (NSArray *)getSupplyRecordData:(NSString *) dbName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *statusArray = nil;
    
    [queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_supplyRecord"];
        while (rs.next) {
            QCSupplyRecordModel *supplyRecord = [[QCSupplyRecordModel alloc] init];
            supplyRecord.userID = [rs stringForColumn:@"userID"];
            supplyRecord.chargeElectDate = [rs stringForColumn:@"time"];
            supplyRecord.supplyElectCost = [[rs stringForColumn:@"cost"] floatValue];
            [statusArray addObject:supplyRecord];
        }
    }];
    [queue close];
    return statusArray;
}

#pragma - mark add and read CP_NUMBER
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
        
#endif
    }];
    [queue close];
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


@end
