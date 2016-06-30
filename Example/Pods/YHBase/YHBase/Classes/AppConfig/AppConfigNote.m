//
//  AppConfigNote.m
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import "AppConfigNote.h"
#import "NSString+BBX.h"

@implementation AppConfigNote

+ (instancetype)shareManager
{
    static AppConfigNote * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[AppConfigNote alloc] init];
        
        NSString *nsLang  = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        NSString *nsCount  = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
        if([nsLang containStr:@"zh"] && [nsCount isEqualToString:@"CN"])
        {
            manager.noteAPPIsInChina = YES;
        }
    });
    
    return manager;
    
    
}



@end
