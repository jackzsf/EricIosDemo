//
//  GXCIA.h
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCIA : NSObject

//设备相关属性
@property(nonatomic,assign) BOOL    isIphone5Size;//是否是iphone5的尺寸 即640*1136
@property(nonatomic,assign) CGFloat osVersion;//系统版本号
@property(nonatomic,assign) BOOL    isIOS7;//是否是ios7及以上version
@property(nonatomic,copy)   NSString    *appUdid;//设备唯一标识
@property(nonatomic,assign) BOOL    isChinese;//系统语言是否是中文
@property(nonatomic,copy)   NSString    *deviceName;//设备名称
@property(nonatomic,copy)   NSString    *pushToken;

//屏幕高度 宽度相关属性
@property(nonatomic,assign) NSInteger scWidth;//屏幕宽度
@property(nonatomic,assign) NSInteger scHeight;//屏幕高度
@property(nonatomic,assign) NSInteger scNavHeight;//导航调高度
@property(nonatomic,assign) NSInteger scStateHeight;//状态栏高度
@property(nonatomic,assign) NSInteger scHeightWithoutState;//除去状态栏的高度
@property(nonatomic,assign) NSInteger scHeightWithoutStateAndNav;//除去状态栏和导航栏的高度
@property(nonatomic,assign) NSInteger scBottomHeight;//底部tabbar的高度

+(id)sharedInstance;

@end

extern GXCIA *CIA;
