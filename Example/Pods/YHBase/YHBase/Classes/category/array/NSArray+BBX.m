//
//  NSArray+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/6/29.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "NSArray+BBX.h"

@implementation NSArray (BBX)

- (id)getObjAtIndex:(NSInteger )index
{
    if(index < 0)
    {
        return nil;
    }
    
    if([self count] > index)
    {
        return self[index];
    }
    return nil;
}

@end
