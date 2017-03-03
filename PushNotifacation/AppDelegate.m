//
//  AppDelegate.m
//  PushNotifacation
//
//  Created by 纵昂 on 2017/3/3.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 在应用程序启动后覆盖自定义点.
    [self registerNotifa]; // 1、注册通知
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 用户通过通知(App未运行,已经杀死)打开程序,这里通过 Badge 就可以观察到
        application.applicationIconBadgeNumber=10;
        UILocalNotification *myLocalNotifa=launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]; // 返回的是本地通知的对象
        NSDictionary *dicValue=myLocalNotifa.userInfo;
        NSString *detailMess=dicValue[@"detailMess"];
        self.myMess=[NSString stringWithFormat:@"%@(通过通知(App未运行,已经杀死)打开程序,这里是具体的通知信息详情)",detailMess];
    }
    else{  // 用户通过App的图片打开的程序
        NSLog(@"用户通过App的图标打开程序");
        application.applicationIconBadgeNumber=0;
        
    }
    return YES;
}
#pragma mark 注册用户通知 ／／1、
-(void)registerNotifa{
    // 因为这里系统大于IOS 8.0,所有不需要考虑IOS 8.0 以下
    
    UIUserNotificationType notifaType=UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    UIUserNotificationSettings *userNotifi=[UIUserNotificationSettings settingsForTypes:notifaType categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotifi];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
#pragma mark -通知有关的代理方法
/** App在后台,程序未被杀死,用户点击了本地通知后的操作 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    // 一定要判断App是否在后台
    if (!(application.applicationState==UIApplicationStateActive)) { // App在后台且用户点击了通知后的操作)
        application.applicationIconBadgeNumber=0;
        NSString *strValue=notification.userInfo[@"detailMess"]; // 这里的 userInfo 对应通知的设置信息 userInfo
        self.myMess=[NSString stringWithFormat:@"%@(App在后台且用户点击了通知后,这里是具体的通知信息详情)",strValue];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"bgckMess" object:nil userInfo:nil];
        NSLog(@"App还在后台,点击了本地通知后,进入这个方法.得到的本地其他信息:%@",notification.userInfo);
    }
    else{
        NSLog(@"App在前台,不用做任何操作");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 当应用程序即将从活动状态转换为非活动状态时发送。 这可能发生在某些类型的临时中断（例如来电或SMS消息）或用户退出应用程序时，并且它开始转换到后台状态.
    // 使用此方法暂停正在进行的任务，禁用计时器，并降低OpenGL ES帧速率。 游戏应该使用这种方法暂停游戏.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 使用此方法释放共享资源，保存用户数据，使计时器无效，并存储足够的应用程序状态信息以将应用程序恢复到其当前状态（如果稍后终止）.
    // 如果您的应用程序支持后台执行，则调用此方法，而不是applicationWillTerminate：当用户退出时.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 被称为从后台到非活动状态的转换的一部分; 在这里你可以撤消许多在输入背景所做的更改.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 在应用程序处于非活动状态时，重新启动已暂停（或尚未启动）的任何任务。 如果应用程序以前在后台，则可选择刷新用户界面.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 在应用程序即将终止时调用。 保存数据（如果适用）。 另请参见applicationDidEnterBackground：.
}

@end
