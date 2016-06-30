//
//  NNJokeManager.h
//  SuoShi
//
//  Created by 林宁宁 on 15/12/31.
//  Copyright © 2015年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNJokeManager : NSObject


+(NNJokeManager *)shareManager;

- (NSString *)getAnyObject;

@property (retain, nonatomic) NSArray  * itemList;

@end

