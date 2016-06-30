//
//  NSString+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/26.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "NSString+BBX.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDateFormatter+BBX.h"
#import "AESCrypt.h"
#import "BBXTool.h"


@implementation NSString (BBX)


-(BOOL)containStr:(NSString *)str
{
    if(!str)
    {
        return NO;
    }
    
    NSRange range = [self rangeOfString:str];
    
    if(range.location != NSNotFound )           //有包含
    {
        return YES;
    }
    return NO;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

//-(BOOL)isEmptyStr
//{
//    if(self && [self isKindOfClass:[NSString class]])
//    {
//        if(![self isEqualToString:@""])
//        {
//            return NO;
//        }
//    }
//    return YES;
//}
//
//
//-(NSString *)nonEmptyStr
//{
//    if(self && [self isKindOfClass:[NSString class]])
//    {
//        return self;
//    }
//    else if ([self isKindOfClass:[NSNumber class]])
//    {
//        NSNumber * strNum = (NSNumber *)self;
//        
//        return [strNum stringValue];
//    }
//    else if ([self isKindOfClass:[NSNull class]])
//    {
//        return @"";
//    }
//    
//    return @"";
//}

-(NSDate *)changeToDate
{
    NSDateFormatter * dateFormatter = [NSDateFormatter defaultDateFormatter];
    
    return [dateFormatter dateFromString:self];
}


-(NSDate *)changeToDateOnlyDay
{
    NSDateFormatter * dateFormatter = [NSDateFormatter defaultDateFormatterOnlyDay];
    
    return [dateFormatter dateFromString:self];
}

- (NSDate *)changeToDateWithHourAndMinutes
{
    NSDateFormatter *formattr=[[NSDateFormatter alloc] init];
    [formattr setDateFormat:@"HH:mm"];
    
    NSString * dateStr = [[NSDate date] description];
    dateStr = [NSString stringWithFormat:@"%@ %@",[[dateStr componentsSeparatedByString:@" "] firstObject],self];
    
    NSDateFormatter * dateFormatter = [NSDateFormatter defaultDateFormatterWithoutSecond];
    
    return [dateFormatter dateFromString:dateStr];
}

-(NSDate *)changeToDateWithoutSecond
{
    NSDateFormatter * dateFormatter = [NSDateFormatter defaultDateFormatterWithoutSecond];
    
    return [dateFormatter dateFromString:self];
}




-(NSUInteger)lengthUnicode {
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        
        
        unichar uc = [self characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    return asciiLength;
//
//    NSUInteger unicodeLength = asciiLength / 2;
//    
//    if(asciiLength % 2) {
//        unicodeLength++;
//    }
//    
//    return unicodeLength;
}


- (NSString *)subStringUnicodeIndex:(NSInteger)toIndex
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        
        unichar uc = [self characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
        
        //超过这个长度了 返回这个之前的字符
        if(asciiLength > toIndex)
        {
            return [self substringToIndex:i];
        }
    }
    
    return self;
}

-(NSUInteger)lengthUTF8
{
    NSInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    return len;
}

-(NSUInteger)lengthUnicode1
{
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}


- (NSString *)encryptWithKeyWord:(NSString *)keyword andKeyOther:(NSString *)keyword2
{
//    return [DESManager encryptBase64Str:self key:keyword];;
    NSString * encrypt1 = [AESCrypt encrypt:self password:keyword];
    encrypt1 = [NSString stringWithFormat:@"%@",encrypt1];

    NSString * udidCreate = [BBXTool uuid];
    if(udidCreate.length > 5)
    {
        encrypt1 = [NSString stringWithFormat:@"%@%@",encrypt1,[udidCreate substringToIndex:5]];
    }
    
    NSString * encrypt2 = [AESCrypt encrypt:encrypt1 password:keyword2];
    return encrypt2;
}

- (NSString *)decryptWithKeyWord:(NSString *)keyword andKeyOther:(NSString *)keyword2
{
    NSString * encrypt1 = [AESCrypt decrypt:self password:keyword2];
    
    if(encrypt1.length > 5)
    {
        encrypt1 = [encrypt1 substringToIndex:encrypt1.length - 5];
    }
    
    NSString * decrypt2 = [AESCrypt decrypt:encrypt1 password:keyword];
    return decrypt2;
}



@end
