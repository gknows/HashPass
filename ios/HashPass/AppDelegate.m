//
//  AppDelegate.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "AppDelegate.h"
#import "HashPassSettingManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([[HashPassSettingManager sharedManager].sendNotification boolValue]) {
        UIUserNotificationType types = UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types == UIUserNotificationTypeNone) {
        [HashPassSettingManager sharedManager].sendNotification = @(NO);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"\"发送到通知栏\"功能打开失败"
                                                        message:@"通知权限已被禁止:(\n如果需要开启此功能，请首先到系统\n\"设置-哈希密码-通知\"\n开启允许通知"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:HPSendNotificationChangedNotification object:nil userInfo:nil];
}


@end
