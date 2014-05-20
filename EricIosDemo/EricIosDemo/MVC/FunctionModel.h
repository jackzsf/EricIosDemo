//
//  FunctionModel.h
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger functionTag;

+(FunctionModel *)dicToModel:(NSDictionary *)dic;
+(NSMutableArray *)dicArrToModelArr:(NSArray *)array;

@end
