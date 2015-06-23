//
//  AppDelegate.m
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.

/**************************************************************
 
 >添加WeichatSDK  并在target->info->URL Type 中添加应用;
 
 >从微信支付的整个业务逻辑来看，前端需要做的操作相对简单，较多工作量留给了后台
    不过在此笔者扩展了下前端的AccessToken获取,生成package,返回最终的prepayid;
 (仅供参考)
 
 >初始化微信支付
 
 >回调相关代理方法
 
**************************************************************/

#import "AppDelegate.h"
#import "WXApi.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    向微信注册APP
    //[WXApi registerApp:@"wx741a39a1910910b0" withDescription:@"zezefamily"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
