//
//  AppDelegate.m
//  EricIosDemo
//
//  Created by Eric on 14-5-15.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "AppDelegate.h"
#import "GXCIA.h"
#import "CommonConstans.h"

AppDelegate *app = nil;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //初始化CIA类 该类主要默默的在后台工作
    [GXCIA sharedInstance];
    app = self;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    
    //如果原来获取过pushtoken  则从本地读取
    if ([UserDefaultsObjectForKey(kDeviceToken) length] > 0)
    {
        CIA.pushToken =UserDefaultsObjectForKey(kDeviceToken);
        NSLog(@"push token is %@",UserDefaultsObjectForKey(kDeviceToken));
    }
    
    [self getPushWhenAppClosed:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //    /*
    NSString *string = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setValue:string forKey:kDeviceToken];
    [[ NSUserDefaults standardUserDefaults] synchronize];
    
    CIA.pushToken = string;
    //     */
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken push token is is %@",[deviceToken description]);
    //    [app showAlertView:[NSString stringWithFormat:@"token is %@",[deviceToken description]]];
    //    [BPush registerDeviceToken:deviceToken];
    //    [BPush bindChannel];
}

#pragma mark -push解析
-(void)getPushWhenAppClosed:(NSDictionary *)launchOptions
{
    NSLog(@"getPushWhenAppClosed... launchOptions is %@",launchOptions);
    if ([launchOptions count] > 0)
    {
        NSDictionary *push = (NSDictionary *)[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        UILocalNotification *localPush = (UILocalNotification *)[launchOptions objectForKey:@"UIApplicationLaunchOptionsLocalNotificationKey"];
        
        if (push!=nil)
        {
//            [self analysePushDic:push];
        }
        else if (localPush!=nil)
        {
//            [self analysePushDic:localPush.userInfo];
        }
    }
}

@end
