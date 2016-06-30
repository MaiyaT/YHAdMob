//
//  BBXDBManager.h
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/1.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface BBXDBManager : NSObject


+ (void)addTableName:(NSString *)tableName andSQLStr:(NSString *)sql;


/** 获取表格中的数据 数组中是字典的数据*/
+ (NSArray *)getDataListFormTableType:(NSString *)type;

/** 来找出某一条的数据*/
+(NSArray *)getDataFromTableType:(NSString *)type withID:(NSDictionary *)dataDic;

/** 更新某一条数据 */
+(void)updateTableType:(NSString *)type withWhereDic:(NSDictionary *)whereDic andUpdateValue:(NSDictionary *)updateValue;

/** 删除某一条数据*/
+ (void)deleteTableType:(NSString *)type withWhereDic:(NSDictionary *)dataDic;

/** 在表格中插入数据 插入的是字典的数据*/
+ (void)insetDataDic:(NSDictionary *)dataDic toTable:(NSString *)typeTab;

/** 在表格中插入数据 插入的是数组的数据 数组中是字典的数据*/
+ (void)insetDataList:(NSArray *)dataList toTable:(NSString *)typeTab;

/** 删除 某个表格*/
+(void)deleteTable:(NSString *)typeTab;

/** 清空 某个*/
+(void)cleanTable:(NSString *)typeTab;

/** 清除这个表格这个用户的信息*/
//+(void)cleanUserInfoTable:(NSString *)typeTab;

/** 判断是否已存在数据库中*/
+ (BOOL)isExitAtTable:(NSString *)typeTab withDataDic:(NSDictionary *)dataDic;

/**
 *  在表格中添加字段  nameStr和nameInt必须填写一个
 *
 *  @param typeTab 表格的类型
 *  @param nameStr 字符类型的字段
 *  @param nameInt 整形类型的字段
 */
+ (void)insetAlterToTable:(NSString *)typeTab andAlertNameStr:(NSString *)nameStr orAlertNameInt:(NSString *)nameInt;

/** 分页选择数据
 select * from messageList  order by messageID desc limit 5 offset 10010
 
 倒叙查询 offset 是 重最后第几条开始 取出几条
 
 */
+ (NSArray *)getPageDataListFormTab:(NSString *)typeTab withKey:(NSString *)mainKey andPageSize:(int)pageSize andOffsetLimit:(int)offset;


/**
 *  获取最大的下标
 */
+ (NSInteger)getMaxIDFromTable:(NSString *)typeTab;


/**
 *  获取最后一条数据
 */
//+ (NSDictionary *)getLastElementFromTab:(NSString *)typeTab;


// 删除数据库
+ (void)deleteDatabse;

@end
