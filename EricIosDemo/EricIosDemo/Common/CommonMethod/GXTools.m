//
//  GXTools.m
//  EricIosDemo
//
//  Created by Eric on 14-5-20.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "GXTools.h"
#import "OpenUDID.h"
#import <sys/sysctl.h>
#include <sys/socket.h> // Per msqr
#include <net/if.h>
#include <net/if_dl.h>

@implementation GXTools

+ (NSString *)getCurrentLanguage
{
    //en   zh-Hans  zh-Hant
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

+ (NSString *)getMacAddress
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >5.99)
    {
        //用了会被apple reject？
        //        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        //
        //        NSLog(@"adId 广告标示符（IDFA-identifierForIdentifier） is %@",adId);
        NSString *adId = [OpenUDID value];
        NSLog(@"getMacAddress OpenUDID value is %@",adId);
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
            free(buf);
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
