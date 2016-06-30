//
//  BBXDBManager.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/1.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "BBXDBManager.h"
#import "FMDB.h"


@implementation BBXDBManager

/**
 *  history_id INTEGER PRIMARY KEY AUTOINCREAMENT       主键
 *  TEXT        字符
 *  INTEGER     整形
 */


/** 获取数据库*/
+ (FMDatabase *)getLocalDataBaseWithTabType:(NSString *)typeTab
{
    FMDatabase * db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        
        return nil;
    }
    
    [self creatTableWithType:typeTab atDB:db];
    
    return db;
}

/** 判断这个表格是否存在 不存在的话 则创建这个表格*/
+ (void)creatTableWithType:(NSString *)typeTab atDB:(FMDatabase *)db
{
    
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    //CREATE TABLE IF NOT EXISTS ***** (history_id INTEGER PRIMARY KEY,uid TEXT, name TEXT, phonenum TEXT, isCollect INTEGER)
    
    //CREATE TABLE IF NOT EXISTS **** (id INTEGER PRIMARY KEY, json TEXT, uid TEXT)
    
    NSString * sql = [self getTableSQLWithTableName:typeTab];
    
    if(sql)
    {
        [db executeUpdate:sql];
    }
}


/** 获取这个表格下的数据 转化成字典*/
+(NSArray *)getDataListFormTableType:(NSString *)type
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:type];
    
    if(!db)
    {
        return @[];
    }
    
    NSMutableArray * list = [[NSMutableArray alloc] init];
    
    //现在表中查询有没有相同的元素，如果有，做修改操作
    NSString * sql = [NSString stringWithFormat:
                      @"SELECT * FROM %@",type];
    
    
    FMResultSet * rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        [list addObject:rs.resultDictionary];
    }
    [db close];
    
    return list;
}

+(NSArray *)getDataFromTableType:(NSString *)type withID:(NSDictionary *)dataDic
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:type];
    
    if(!db)
    {
        return @[];
    }
    
    NSMutableArray * list = [[NSMutableArray alloc] init];
    
    NSString * whereSql = [self queryWhereSQLWithDataDic:dataDic andTableT:type];
    FMResultSet * rs = [db executeQuery:whereSql];
    
    while ([rs next])
    {
        [list addObject:rs.resultDictionary];
    }
    [db close];
    
    return list;
}

+(void)updateTableType:(NSString *)type withWhereDic:(NSDictionary *)whereDic andUpdateValue:(NSDictionary *)updateValue
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:type];
    
    if(!db)
    {
        return;
    }
    
    NSString * queryStr = [self queryWhereSQLWithDataDic:whereDic andTableT:type];
    
    FMResultSet *rs = [db executeQuery:queryStr];
    
    if([rs next])
    {
        [db executeUpdate:[self queryUpdateSQLWithWhereDataDic:whereDic andUpdateValue:updateValue andTableT:type]];
    }
    
    [db close];
}

+(void)deleteTableType:(NSString *)type withWhereDic:(NSDictionary *)dataDic
{
    //DELETE FROM Person WHERE LastName = 'Wilson'
    FMDatabase * db = [self getLocalDataBaseWithTabType:type];
    
    if(!db)
    {
        return;
    }
    
    NSString * queryStr = [self deleteWhereSQLWithDataDic:dataDic andTableT:type];
    
    BOOL res = [db executeUpdate:queryStr];
    
    if (res) {
        NSLog(@"删除成功");
    }
    
    
    [db close];
    
}

+ (BOOL)isExitAtTable:(NSString *)typeTab withDataDic:(NSDictionary *)dataDic
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return NO;
    }
    
    NSString * whereSql = [self queryWhereSQLWithDataDic:dataDic andTableT:typeTab];
    FMResultSet * rs = [db executeQuery:whereSql];
    
    BOOL isExit = NO;
    
    while ([rs next])
    {
        isExit = YES;
    }
    
    [db close];
    
    return isExit;
}

+(void)insetDataDic:(NSDictionary *)dataDic toTable:(NSString *)typeTab
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return;
    }
    
    NSString * insertSql = [self insetSqlWithDataDic:dataDic andTableT:typeTab];
    BOOL res = [db executeUpdate:insertSql];
    
    if (res) {
        //        NSLog(@"success to insert db table");
    }
    else
    {
        NSLog(@"插入失败");
    }
    
    [db close];
}

+ (NSInteger)getMaxIDFromTable:(NSString *)typeTab
{
    //    select max(id) from tab_note
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return 100;
    }
    
    NSString * getSql = [NSString stringWithFormat:@"select max(id) from %@",typeTab];
    FMResultSet * rs = [db executeQuery:getSql];
    
    NSInteger maxIndex = 0;
    
    while ([rs next])
    {
        NSLog(@"%@",rs);
        maxIndex = [[[rs.resultDictionary allValues] firstObject] integerValue];
    }
    [db close];
    
    return maxIndex;
}

+(void)insetDataList:(NSArray *)dataList toTable:(NSString *)typeTab
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return;
    }
    
    for(NSDictionary * dataDic in dataList)
    {
        BOOL res = [db executeUpdate:[self insetSqlWithDataDic:dataDic andTableT:typeTab]];
        
        if (res) {
            NSLog(@"插入成功");
        }
    }
    
    
    
    [db close];
}

/** delete 的查询语句*/
+ (NSString *)deleteWhereSQLWithDataDic:(NSDictionary *)dataDic andTableT:(NSString *)typeTab
{
    //    SELECT * FROM histoySmsContacts  WHERE name = 'HigginsDaniel' and phonenum = '(408) 555-3514'
    
    NSMutableString * whereSql = [[NSMutableString alloc] init];
    
    if(dataDic.count > 0)
    {
        [whereSql appendFormat:@"DELETE FROM %@ WHERE ",typeTab];
        
        NSArray * allKeys = [dataDic allKeys];
        for(NSString * key in allKeys)
        {
            NSString * value = dataDic[key];
            
            [whereSql appendFormat:@"%@ = ",key];
            [whereSql appendFormat:@"'%@'",value];
            
            if(![key isEqualToString:[allKeys lastObject]])
            {
                [whereSql appendString:@" and "];
            }
        }
    }
    
    
    
    return whereSql;
}



/** where 的查询语句*/
+ (NSString *)queryWhereSQLWithDataDic:(NSDictionary *)dataDic andTableT:(NSString *)typeTab
{
    //    SELECT * FROM histoySmsContacts  WHERE name = 'HigginsDaniel' and phonenum = '(408) 555-3514'
    
    NSMutableString * whereSql = [[NSMutableString alloc] init];
    
    NSMutableDictionary * uidDataDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
    
    
    if(dataDic.count > 0)
    {
        [whereSql appendFormat:@"SELECT * FROM %@ WHERE ",typeTab];
        
        NSArray * allKeys = [uidDataDic allKeys];
        for(NSString * key in allKeys)
        {
            NSString * value = uidDataDic[key];
            
            [whereSql appendFormat:@"%@ = ",key];
            [whereSql appendFormat:@"'%@'",value];
            
            if(![key isEqualToString:[allKeys lastObject]])
            {
                [whereSql appendString:@" and "];
            }
        }
    }
    
    
    
    return whereSql;
}

/**
 *  在表格中添加字段  nameStr和nameInt必须填写一个
 *
 *  @param typeTab 表格的类型
 *  @param nameStr 字符类型的字段
 *  @param nameInt 整形类型的字段
 */
+ (void)insetAlterToTable:(NSString *)typeTab andAlertNameStr:(NSString *)nameStr orAlertNameInt:(NSString *)nameInt
{
    //alter table 表名 add 字段名 类型
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return;
    }
    
    NSString * addAlterStr;
    
    if(nameStr)
    {
        addAlterStr = [NSString stringWithFormat:@"alter table %@ add %@ %@",typeTab,nameStr,@"TEXT"];
    }
    else if (nameInt)
    {
        addAlterStr = [NSString stringWithFormat:@"alter table %@ add %@ %@",typeTab,nameInt,@"INTEGER"];
    }
    
    BOOL res = [db executeUpdate:addAlterStr];
    
    if (res) {
        NSLog(@"添加成功");
    }
    
    
    [db close];
}

/** update 的查询语句*/
+ (NSString *)queryUpdateSQLWithWhereDataDic:(NSDictionary *)whereDic andUpdateValue:(NSDictionary *)updateValue andTableT:(NSString *)typeTab
{
    //    SELECT * FROM histoySmsContacts  WHERE name = 'HigginsDaniel' and phonenum = '(408) 555-3514'
    //    update %@ set name = ?, age = ? where people_id = 1"
    
    NSMutableString * whereSql = [[NSMutableString alloc] init];
    
    
    NSMutableDictionary * updateValueUser = [[NSMutableDictionary alloc] initWithDictionary:updateValue];
    
    
    if(updateValue.count > 0)
    {
        [whereSql appendFormat:@"UPDATE %@ SET ",typeTab];
        
        NSArray * allKeys = [updateValueUser allKeys];
        for(NSString * key in allKeys)
        {
            NSString * value = updateValueUser[key];
            
            [whereSql appendFormat:@"%@ = ",key];
            [whereSql appendFormat:@"'%@'",value];
            
            if(![key isEqualToString:[allKeys lastObject]])
            {
                [whereSql appendString:@" , "];
            }
        }
        
        [whereSql appendFormat:@" WHERE %@ = '%@'",[[whereDic allKeys] firstObject],[[whereDic allValues] firstObject]];
    }
    //UPDATE historyAddress SET uid = '50f64eb41195d3096e756e4139f7e981' , longitude = '1' , title = '厦门市 厦禾路885号罗宾森购物广场内(近湖滨东路)乐购(罗宾森店)2层' , latitude = '24.47512015426296' , addID = '2' , isCollect = '0' , subTitle = 'E.T' WHERE addID = '2'
    
    
    return whereSql;
}

/** 插入的语句*/
+ (NSString *)insetSqlWithDataDic:(NSDictionary *)dataDic andTableT:(NSString *)typeTab
{
    NSMutableDictionary * dataDicUser = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
    
    
    NSMutableString * insertSql = [[NSMutableString alloc] init];
    
    if(dataDic.count > 0)
    {
        [insertSql appendFormat:@"INSERT INTO %@",typeTab];
        
        NSMutableString * keys = [[NSMutableString alloc] init];
        NSMutableString * values = [[NSMutableString alloc] init];
        
        [keys appendString:@" ("];
        [values appendString:@" ("];
        
        NSArray * allKeys = [dataDicUser allKeys];
        for(NSString * key in allKeys)
        {
            NSString * value = dataDicUser[key];
            
            [keys appendFormat:@"'%@'",key];
            [values appendFormat:@"'%@'",value];
            
            if([key isEqualToString:[allKeys lastObject]])
            {
                [keys appendString:@")"];
                [values appendString:@")"];
            }
            else
            {
                [keys appendString:@", "];
                [values appendString:@", "];
            }
        }
        
        [insertSql appendFormat:@"%@",keys];
        [insertSql appendString:@" VALUES "];
        [insertSql appendFormat:@"%@",values];
    }
    
    return insertSql;
}

/** 分页选择数据
 select * from messageList  order by messageID desc limit 5 offset 10010
 */
+ (NSArray *)getPageDataListFormTab:(NSString *)typeTab withKey:(NSString *)mainKey andPageSize:(int)pageSize andOffsetLimit:(int)offset
{
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return @[];
    }
    
    NSMutableArray * list = [[NSMutableArray alloc] init];
    
    //现在表中查询有没有相同的元素，如果有，做修改操作
    NSString * sql = [NSString stringWithFormat:
                      @"select * from %@  order by %@ desc limit %d offset %d",typeTab,mainKey,pageSize,offset];
    
    
    FMResultSet * rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        [list addObject:rs.resultDictionary];
    }
    [db close];
    
    return list;
}


+(void)deleteTable:(NSString *)typeTab
{
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@",typeTab];
    
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return;
    }
    
    if (![db executeUpdate:sqlstr])
    {
        NSLog(@"删除表  成功");
    }
    
    [db close];
}

+(void)cleanTable:(NSString *)typeTab
{
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@",typeTab];
    
    FMDatabase * db = [self getLocalDataBaseWithTabType:typeTab];
    
    if(!db)
    {
        return;
    }
    
    if (![db executeUpdate:sqlstr])
    {
        NSLog(@"清除表  histoySmsContacts  成功");
    }
    
    [db close];
}




#pragma mark -


+(NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"bbx.sqlite"];
    
    NSLog(@"==============%@",dbFilePath);
    
    return dbFilePath;
}


// 删除数据库
+ (void)deleteDatabse
{
    BOOL success;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // delete the old db.
    if ([fileManager fileExistsAtPath:[self databaseFilePath]])
    {
        success = [fileManager removeItemAtPath:[self databaseFilePath] error:&error];
        if (!success) {
            NSAssert(FALSE, @"%@,%s,%d,%s",[error localizedDescription],__FILE__, __LINE__, __FUNCTION__);
        }
    }
}


+ (void)addTableName:(NSString *)tableName andSQLStr:(NSString *)sql
{
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    
    NSDictionary * localTabs = [[NSUserDefaults standardUserDefaults] objectForKey:@"dbtabs"];
    
    if(localTabs)
    {
        [dataDic addEntriesFromDictionary:localTabs];
    }
    
    [dataDic setObject:sql forKey:tableName];
    
    [[NSUserDefaults standardUserDefaults] setObject:dataDic forKey:@"dbtabs"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)getTableSQLWithTableName:(NSString *)tablename
{
    NSDictionary * localTabs = [[NSUserDefaults standardUserDefaults] objectForKey:@"dbtabs"];
    
    return [localTabs objectForKey:tablename];
}

@end
