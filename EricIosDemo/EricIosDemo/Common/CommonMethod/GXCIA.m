//
//  GXCIA.m
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "GXCIA.h"
#import "GXTools.h"
#import "DeviceDetection.h"

#define ScreenStateHeight   20
#define ScreenNavHeight     44
#define ScreenBottomHeight  44

GXCIA *CIA =nil;

@implementation GXCIA

+(id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    CIA = _sharedObject;
    [_sharedObject initSomeData];
    
    return _sharedObject;
}

-(void)initSomeData
{
    self.scWidth = [[UIScreen mainScreen] currentMode].size.width;
    self.scHeight = [[UIScreen mainScreen] currentMode].size.height;
    self.scNavHeight = ScreenNavHeight;
    self.scStateHeight = ScreenStateHeight;
    self.scHeightWithoutState = self.scHeight - self.scStateHeight;
    self.scHeightWithoutStateAndNav = self.scHeightWithoutState - self.scNavHeight;
    self.scBottomHeight = ScreenBottomHeight;
    
    self.isIphone5Size = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
    self.osVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (self.osVersion > 6.99)
    {
        self.isIOS7 = YES;
    }
    else
    {
        self.isIOS7 = NO;
    }
    
    self.appUdid = [NSString md5:[GXTools getMacAddress]];
    
    NSString *languageStr = [GXTools getCurrentLanguage];
    if ([languageStr isEqualToString:@"zh-Hans"] || [languageStr isEqualToString:@"zh-Hant"])
    {
        self.isChinese = YES;
    }
    else
    {
        self.isChinese = NO;
    }
    
    self.deviceName = [DeviceDetection returnDeviceName];
    
    NSString *oldPushToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if ([oldPushToken length] > 0)
    {
        self.pushToken = oldPushToken;
    }
    else
    {
        self.pushToken = @"";
    }
    
    NSLog(@"CIA Log is***********\nIphone5Size is %hhd\nosVersion is %.2f\nappUdid is %@\ndeviceName is %@",self.isIphone5Size,self.osVersion,self.appUdid,self.deviceName);
}

@end
