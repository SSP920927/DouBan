//
//  AppDelegate.m
//  doubanRead
//
//  Created by 杜守鹏 on 16/1/13.
//  Copyright © 2016年 杜守鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "LauchViewController.h"
#import "NewfeatureController.h"
#import "MainController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark 设置根控制器为启动动画控制器
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
       UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LauchStoryboard"bundle:nil];
    UIViewController *lauchController = [sb instantiateInitialViewController];
    self.window.rootViewController = lauchController;

//           UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil];
//        UIViewController *mainController = [sb instantiateInitialViewController];
//    self.window.rootViewController = mainController;
    [self.window makeKeyAndVisible];
    
    //接受通知，切换根控制器到主控制器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootControllerToMainController) name:@"changeRootControllerToMainController" object:nil];
    return YES;
}

-(void)changeRootControllerToMainController{
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
               UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil];
            UIViewController *mainController = [sb instantiateInitialViewController];
        self.window.rootViewController = mainController;
    keywindow.rootViewController = mainController;
    
//    keywindow.rootViewController = [[MainController alloc]init];
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
