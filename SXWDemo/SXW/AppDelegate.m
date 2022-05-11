//
//  AppDelegate.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/24.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "AppDelegate.h"
#import "SXWMainViewController.h"
#import "SplashScreenView.h"
#import "SplashScreenDataManager.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [WeiboSDK registerApp:WBAppid];
    
    // 改变所有光标颜色
    [[UITextField appearance] setTintColor:JMColor(153, 153, 153)];
    [[UITextView appearance] setTintColor:JMColor(153, 153, 153)];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    SXWMainViewController * vc = [[SXWMainViewController alloc] init];
    self.window.rootViewController = vc;
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];
    
//    // 1.判断沙盒中是否存在广告图片
//    NSString *filePath = [SplashScreenDataManager getFilePathWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:adImageName]];
//    BOOL isExist = [SplashScreenDataManager isFileExistWithFilePath:filePath];
//    if (isExist)
//    {// 图片存在
//        SplashScreenView *advertiseView = [[SplashScreenView alloc] initWithFrame:self.window.bounds];
//        advertiseView.imgFilePath = filePath;
//        advertiseView.imgLinkUrl = [[NSUserDefaults standardUserDefaults] valueForKey:adUrl];
//        advertiseView.imgDeadline = [[NSUserDefaults standardUserDefaults] valueForKey:adDeadline];
//        //设置广告页显示的时间
//        [advertiseView showSplashScreenWithTime:3];
//    }
//    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
//    [SplashScreenDataManager getAdvertisingImageData];
    
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
//    [WeiboSDK handleOpenURL:url delegate:[WBApiManager sharedManager]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
