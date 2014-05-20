//
//  GXTools.h
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTools : NSObject

//获取系统语言
+ (NSString *)getCurrentLanguage;
//获取系统唯一地址
+ (NSString *)getMacAddress;

@end
