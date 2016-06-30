//
//  BannerManager.m
//  BannerBrush
//
//  Created by 林宁宁 on 15/11/4.
//  Copyright © 2015年 000. All rights reserved.
//

#import "BannerManager.h"
#import "BBXDBManager.h"
#import "AppConfigNote.h"


@implementation BannerManager

+(BannerManager *)shareManager
{
    static BannerManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BannerManager alloc] init];
        
        
        ADItem * itemGDT = [[ADItem alloc] init];
        itemGDT.adKey = [AppConfigNote shareManager].noteADGDTKey;
        itemGDT.adKaiping = [AppConfigNote shareManager].noteADGDTKaiping;
        itemGDT.adPosList = [AppConfigNote shareManager].noteADGDTBanners;
        itemGDT.adChaping = [AppConfigNote shareManager].noteADGDTChaping;
        itemGDT.adType = @"gdt";
        itemGDT.adTime = 60;
        
        
        
        ADItem * itemADMob = [[ADItem alloc] init];
        itemADMob.adKey = [AppConfigNote shareManager].noteADADMobKey;
        itemADMob.adKaiping = [AppConfigNote shareManager].noteADADMobKaiping;
        itemADMob.adPosList = [AppConfigNote shareManager].noteADADMobBanners;
        itemADMob.adChaping = [AppConfigNote shareManager].noteADADMobChaping;
        itemADMob.adType = @"admob";
        itemADMob.adTime = 60;
        
        
        manager.appADScaleGDT = 0.5;
        manager.appADList = @[itemGDT,itemADMob];
        
        [manager readFromLocal];

    });
    return manager;
}



/**
 *  保存到本地
 */
- (void)saveToLocal
{
    NSMutableDictionary * bannerDic = [[NSMutableDictionary alloc] init];
    
    [bannerDic setObject:@(self.appADScaleGDT) forKey:@"scale_gdt"];
    
    if(self.appADList.count > 0)
    {
        NSMutableArray * dataList = [[NSMutableArray alloc] init];
        for(ADItem * item in self.appADList)
        {
            [dataList addObject:[item getADDataDic]];
        }
        
        [bannerDic setObject:dataList forKey:@"list"];
    }
    
    NSString * jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:bannerDic options:NSJSONWritingPrettyPrinted error:nil] encoding:4];
    
    [BBXDBManager cleanTable:@"tab_banner"];
    
    [BBXDBManager addTableName:@"tab_banner" andSQLStr:@"CREATE TABLE IF NOT EXISTS tab_banner (id INTEGER PRIMARY KEY, json TEXT)"];
    
    [BBXDBManager insetDataDic:@{@"json":jsonStr} toTable:@"tab_banner"];
}

- (void)readFromLocal
{
    NSDictionary * dataDic = [[BBXDBManager getDataListFormTableType:@"tab_banner"] firstObject];
    
    [self updateContentWithDataDic:dataDic];
}

- (void)updateContentWithDataDic:(NSDictionary *)dataDic
{
    if([dataDic isKindOfClass:[NSDictionary class]])
    {
        NSString * jsonStr = dataDic[@"json"];
        if([jsonStr isKindOfClass:[NSString class]])
        {
            id dataJson = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:4] options:NSJSONReadingMutableContainers error:nil];
            if([dataJson isKindOfClass:[NSDictionary class]])
            {
                dataDic = dataJson;
            }
        }
        
        id obj = dataDic[@"list"];
        if([obj isKindOfClass:[NSArray class]])
        {
            NSMutableArray * dataList = [[NSMutableArray alloc] init];
            for(NSDictionary * adDic in obj)
            {
                [dataList addObject:[[ADItem alloc] initWithDataDic:adDic]];
            }
            self.appADList = dataList;
        }
        
        obj = dataDic[@"scale_gdt"];
        if(obj && ![obj isKindOfClass:[NSNull class]])
        {
            self.appADScaleGDT = [obj floatValue];
        }
    }
    
}


/**
 *  根据概率看显示什么广告
 */
- (ADItem *)showAD
{
    float arcValue = arc4random()%1000;
    arcValue = arcValue/1000.0;
    
    if(arcValue > self.appADScaleGDT)
    {
        //显示admob
        for(ADItem * item in self.appADList)
        {
            if([item.adType isEqualToString:@"admob"])
            {
                return item;
            }
        }
    }
    else
    {
        //广点通
        for(ADItem * item in self.appADList)
        {
            if([item.adType isEqualToString:@"gdt"])
            {
                return item;
            }
        }
    }
    
    return nil;
}



@end




@implementation ADItem


- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    
    if(self)
    {
        if(![dataDic isKindOfClass:[NSDictionary class]])
        {
            return self;
        }
        
        id obj = dataDic[@"adType"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.adType = obj;
        }
        
        obj = dataDic[@"adKey"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.adKey = obj;
        }
        
        obj = dataDic[@"adChaping"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.adChaping = obj;
        }
        
        obj = dataDic[@"adKaiping"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.adKaiping = obj;
        }
        
        obj = dataDic[@"adPosList"];
        if([obj isKindOfClass:[NSArray class]])
        {
            self.adPosList = [NSArray arrayWithArray:obj];
        }
        
        obj = dataDic[@"adTime"];
        if(obj && ![obj isKindOfClass:[NSNull class]])
        {
            self.adTime = [obj floatValue];
        }
        
    }
    return self;
}

- (NSDictionary *)getADDataDic
{
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    
    if(self.adType)
    {
        [dataDic setObject:self.adType forKey:@"adType"];
    }
    
    if(self.adKey)
    {
        [dataDic setObject:self.adKey forKey:@"adKey"];
    }
    
    if(self.adChaping)
    {
        [dataDic setObject:self.adChaping forKey:@"adChaping"];
    }
    
    if (self.adKaiping)
    {
        [dataDic setObject:self.adKaiping forKey:@"adKaiping"];
    }
    
    if(self.adPosList.count > 0)
    {
        [dataDic setObject:self.adPosList forKey:@"adPosList"];
    }
    
    [dataDic setObject:@(self.adTime) forKey:@"adTime"];
    
    return dataDic;
}

- (NSString *)getShowBanner
{
    if(self.adPosList.count > 0)
    {
        return self.adPosList[(arc4random()%1000)%self.adPosList.count];
    }
    
    return nil;
}


@end
