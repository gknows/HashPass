//
//  HashPassSettingModel.h
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HP_HASH_MD5             @"md5"
#define HP_HASH_SHA1            @"sha1"
#define HP_HASH_SHA224          @"sha224"
#define HP_HASH_SHA256          @"sha256"
#define HP_HASH_SHA384          @"sha384"
#define HP_HASH_SHA512          @"sha512"

#define HPSendNotificationChangedNotification @"HPSendNotificationChangedNotification"

@interface HashPassSettingManager : NSObject

@property (nonatomic, strong) NSNumber *alreadySet;
@property (nonatomic, strong) NSNumber *hideSettingButton;

@property (nonatomic, strong) NSString *personalKey;
@property (nonatomic, strong) NSString *hashType;
@property (nonatomic, strong) NSNumber *hashTimes;
@property (nonatomic, strong) NSNumber *passwordLength;
@property (nonatomic, strong) NSNumber *caseMixed;

@property (nonatomic, strong) NSNumber *sendToClipboard;
@property (nonatomic, strong) NSNumber *sendNotification;

+ (instancetype)sharedManager;
- (NSArray<NSString *> *)allSupportHashType;

@end
