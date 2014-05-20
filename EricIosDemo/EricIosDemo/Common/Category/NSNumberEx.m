//
//  NSNumberEx.m
//  Yiban
//
//  Created by 赛锋 张 on 12-5-24.
//  Copyright (c) 2012年 eric. All rights reserved.
//

#import "NSNumberEx.h"


@implementation NSNumber (NSNumberEx)

- (NSUInteger)length
{
    NSString *numStr = [NSString stringWithFormat:@"%@", self];
    if ([numStr respondsToSelector:@selector(intValue)])
    {
        return [numStr length];
    }
    else
    {
        return 0;
    }
}

@end
