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

#define HP_SEND_NOTIFICATION_FAILED_TITLE  NSLocalizedString(@"HP_SEND_NOTIFICATION_FAILED_TITLE", @"send notification setting failed title")
#define HP_SEND_NOTIFICATION_FAILED_DETAIL NSLocalizedString(@"HP_SEND_NOTIFICATION_FAILED_DETAIL", @"send notification setting failed detail")
#define HP_SEND_NOTIFICATION_FAILED_CONFIRM NSLocalizedString(@"HP_SEND_NOTIFICATION_FAILED_CONFIRM", @"send notification setting failed confirm")
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types == UIUserNotificationTypeNone) {
        [HashPassSettingManager sharedManager].sendNotification = @(NO);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:HP_SEND_NOTIFICATION_FAILED_TITLE
                                                        message:HP_SEND_NOTIFICATION_FAILED_DETAIL
                                                       delegate:nil
                                              cancelButtonTitle:HP_SEND_NOTIFICATION_FAILED_CONFIRM
                                              otherButtonTitles:nil];
        [alert show];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:HPSendNotificationChangedNotification object:nil userInfo:nil];
}


@end
