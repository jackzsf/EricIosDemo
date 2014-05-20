//
//  DeviceDetection.m
//  UVANMobile
//
//  Created by shen xu on 10-9-20.
//  Copyright 2010 SDT. All rights reserved.
//

#import "DeviceDetection.h"
#import <sys/utsname.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"
#import "CommonConstans.h"

@implementation DeviceDetection

+ (uint) detectDevice
{
    struct utsname u;
    uname(&u);
    NSString *platform = [NSString stringWithCString:u.machine encoding: NSUTF8StringEncoding];
    NSLog(@"platform is %@",platform);
    if ([platform isEqualToString:@"iFPGA"])		return UIDeviceIFPGA;
    
	if ([platform isEqualToString:@"iPhone1,1"])	return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"])	return UIDevice3GiPhone;
	if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
	if ([platform hasPrefix:@"iPhone3"])			return UIDevice4iPhone;
	if ([platform hasPrefix:@"iPhone4"])			return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone5"])			return UIDevice6iPhone;
    if ([platform hasPrefix:@"iPhone5s"])			return UIDevice6siPhone;
    if ([platform hasPrefix:@"iPhone5c"])			return UIDevice6ciPhone;
	
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"])   return UIDevice4GiPod;
    if ([platform isEqualToString:@"iPod5,1"])   return UIDevice5GiPod;
    
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"])   return UIDevice2GiPad;
    if ([platform isEqualToString:@"iPad3,1"])   return UIDevice3GiPad;
	if ([platform isEqualToString:@"iPad4,1"])   return UIDevice4GiPad;
	
	if ([platform isEqualToString:@"AppleTV2,1"])	return UIDeviceAppleTV2;
	
	/*
	 MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.... SORRY!
	 */
	
    if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;
    
	if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
	{
		if ([[UIScreen mainScreen] bounds].size.width < 768)
			return UIDeviceiPhoneSimulatoriPhone;
		else
			return UIDeviceiPhoneSimulatoriPad;
        
		return UIDeviceiPhoneSimulator;
	}
    
	return UIDeviceUnknown;
}

+ (NSString *) returnDeviceName
{
    NSString *returnValue = @"Unknown";
    
    switch ([DeviceDetection detectDevice])
	{
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone:	return IPHONE_3GS_NAMESTRING;
		case UIDevice4iPhone:	return IPHONE_4_NAMESTRING;
		case UIDevice5iPhone:	return IPHONE_5_NAMESTRING;
        case UIDevice6iPhone:	return IPHONE_6_NAMESTRING;
        case UIDevice6siPhone:	return IPHONE_6s_NAMESTRING;
        case UIDevice6ciPhone:	return IPHONE_6c_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod: return IPOD_5G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
		case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
		case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
			
		case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
			
		case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPhone: return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
		case UIDeviceiPhoneSimulatoriPad: return IPHONE_SIMULATOR_IPAD_NAMESTRING;
			
		case UIDeviceIFPGA: return IFPGA_NAMESTRING;
			
		default: return IPOD_FAMILY_UNKNOWN_DEVICE;
    }
    
    return returnValue;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *)getMacAddress
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >5.99)
    {
//        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//        
//        NSLog(@"adId 广告标示符（IDFA-identifierForIdentifier） is %@",adId);
        NSString *adId = [OpenUDID value];

        return adId;
    }
    else
    {
        int					mib[6];
        size_t				len;
        char				*buf;
        unsigned char		*ptr;
        struct if_msghdr	*ifm;
        struct sockaddr_dl	*sdl;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0) {
            printf("Error: if_nametoindex error\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 1\n");
            return NULL;
        }
        
        if ((buf = malloc(len)) == NULL) {
            printf("Could not allocate memory. error!\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 2");
            return NULL;
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        if ([outstring length] > 0)
        {
            NSLog(@"outstring is %@",outstring);
        }
        free(buf);
        return [outstring uppercaseString];
    }
	
}


@end
