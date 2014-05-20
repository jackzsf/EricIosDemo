//
//  CommonConstans.h
//  GuanXi
//
//  Created by hepeilin on 13-11-5.
//  Copyright (c) 2013年 minfo. All rights reserved.
//

#ifndef GuanXi_CommonConstans_h
#define GuanXi_CommonConstans_h

//颜色的宏定义
#define    RedColor     [UIColor redColor]
#define    WhiteColor   [UIColor whiteColor]
#define    BlackColor   [UIColor blackColor]
#define    YellowColor  [UIColor yellowColor]
#define    GrayColor    [UIColor grayColor]
#define    BlueColor    [UIColor blueColor]
#define    ClearColor   [UIColor clearColor]


//NSUserDefaults相关
#define UserDefaultsObjectForKey(key)             [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UserDefaultsSetValueForKey(value,key)     [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define UserDefaultSynchronize                    [[NSUserDefaults standardUserDefaults] synchronize]


#define Frame(x,y,w,h) CGRectMake(x, y, w, h)

enum {
    UIDeviceUnknown,
	
	UIDeviceiPhoneSimulator,
	UIDeviceiPhoneSimulatoriPhone, // both regular and iPhone 4 devices
	UIDeviceiPhoneSimulatoriPad,
	
	UIDevice1GiPhone,
	UIDevice3GiPhone,
	UIDevice3GSiPhone,
	UIDevice4iPhone,
	UIDevice5iPhone,
    UIDevice6iPhone,
    UIDevice6siPhone,
    UIDevice6ciPhone,
	
	UIDevice1GiPod,
	UIDevice2GiPod,
	UIDevice3GiPod,
	UIDevice4GiPod,
    UIDevice5GiPod,
	
	UIDevice1GiPad, // both regular and 3G
	UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
	
	UIDeviceAppleTV2,
	
	UIDeviceUnknowniPhone,
	UIDeviceUnknowniPod,
	UIDeviceUnknowniPad,
	UIDeviceIFPGA,
	UNKNOW = -1
};

#define IFPGA_NAMESTRING				@"iFPGA"

#define IPHONE_1G_NAMESTRING			@"iPhone_1G"
#define IPHONE_3G_NAMESTRING			@"iPhone_3G"
#define IPHONE_3GS_NAMESTRING			@"iPhone_3GS"
#define IPHONE_4_NAMESTRING				@"iPhone_4"
#define IPHONE_5_NAMESTRING				@"iPhone_4S"
#define IPHONE_6_NAMESTRING				@"iPhone_5"
#define IPHONE_6s_NAMESTRING            @"iPhone_5s"
#define IPHONE_6c_NAMESTRING			@"iPhone_5c"
#define IPHONE_UNKNOWN_NAMESTRING		@"Unknown_iPhone"

#define IPOD_1G_NAMESTRING				@"iPod_touch_1G"
#define IPOD_2G_NAMESTRING				@"iPod_touch_2G"
#define IPOD_3G_NAMESTRING				@"iPod_touch_3G"
#define IPOD_4G_NAMESTRING				@"iPod_touch_4G"
#define IPOD_5G_NAMESTRING				@"iPod_touch_5G"
#define IPOD_UNKNOWN_NAMESTRING			@"Unknown_iPod"

#define IPAD_1G_NAMESTRING				@"iPad_1G"
#define IPAD_2G_NAMESTRING				@"iPad_2G"
#define IPAD_3G_NAMESTRING				@"iPad_3G"
#define IPAD_4G_NAMESTRING				@"iPad_4G"
#define IPAD_UNKNOWN_NAMESTRING			@"Unknown_iPad"

// Nano? Apple TV?
#define APPLETV_2G_NAMESTRING			@"Apple_TV_2G"

#define IPOD_FAMILY_UNKNOWN_DEVICE			@"Unknown_iOS_device"

#define IPHONE_SIMULATOR_NAMESTRING			@"iPhone_Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING	@"iPhone_Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING	@"iPad_Simulator"


#endif
