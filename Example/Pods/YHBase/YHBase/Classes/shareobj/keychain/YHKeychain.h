//
//  YHKeychain.h
//  直播吧
//
//  Created by LinNingNing on 14-1-4.
//
//

#import <Foundation/Foundation.h>

@interface YHKeychain : NSObject

+ (void)keyChainSave:(NSString *)service data:(id)data;

+ (id)keyChainLoad:(NSString *)service;

+ (void)keyChainDelete:(NSString *)service;

@end
