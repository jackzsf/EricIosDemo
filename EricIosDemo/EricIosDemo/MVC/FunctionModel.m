//
//  FunctionModel.m
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "FunctionModel.h"

@implementation FunctionModel

+(FunctionModel *)dicToModel:(NSDictionary *)dic
{
    FunctionModel *model = [[FunctionModel alloc] init];
    
    if ([[dic objectForKey:@"name"] length] > 0)
    {
        model.name = [dic objectForKey:@"name"];
    }
    else
    {
        model.name = @"";
    }
    
    if ([[dic objectForKey:@"tag"] length] > 0)
    {
        model.functionTag = [[dic objectForKey:@"tag"] intValue];
    }
    else
    {
        model.functionTag = 0;
    }
    
    return model;
}

+(NSMutableArray *)dicArrToModelArr:(NSArray *)array
{
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    if ([array count] > 0)
    {
        for(NSDictionary *dic in array)
        {
            [resultArr addObject:[self dicToModel:dic]];
        }
    }
    
    return resultArr;
}
@end
