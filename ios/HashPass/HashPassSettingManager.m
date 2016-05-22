//
//  HashPassSettingModel.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "HashPassSettingManager.h"

#define HP_ALREADY_SET          @"already_set"
#define HP_HIDE_SETTING_BUTTON  @"hide_setting_button"
#define HP_PERSONAL_KEY         @"personal_key"
#define HP_HASH_TYPE            @"hash_type"
#define HP_HASH_TIMES           @"hash_times"
#define HP_PASSWORD_LENGTH      @"password_length"
#define HP_CASE_MIXED           @"case_mixed"
#define HP_SEND_TO_CLIPBOARD    @"send_to_clipboard"
#define HP_SEND_NOTIFICATION    @"send_notification"



@implementation HashPassSettingManager

@synthesize alreadySet = _alreadySet;
@synthesize hideSettingButton = _hideSettingButton;
@synthesize personalKey = _personalKey;
@synthesize hashType = _hashType;
@synthesize hashTimes = _hashTimes;
@synthesize passwordLength = _passwordLength;
@synthesize caseMixed = _caseMixed;
@synthesize sendToClipboard = _sendToClipboard;
@synthesize sendNotification = _sendNotification;

+ (instancetype)sharedManager
{
    static HashPassSettingManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HashPassSettingManager alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - AlreadySet
- (NSNumber *)alreadySet
{
    if (_alreadySet != nil) {
        return _alreadySet;
    }
    _alreadySet = [[NSUserDefaults standardUserDefaults] valueForKey:HP_ALREADY_SET];
    return _alreadySet?:@(NO);
}

- (void)setAlreadySet:(NSNumber *)alreadySet
{
    if ([_alreadySet isEqualToNumber:alreadySet]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:alreadySet forKey:HP_ALREADY_SET];
    _alreadySet = alreadySet;
}

#pragma mark - HideSettingButton
- (NSNumber *)hideSettingButton
{
    if (_hideSettingButton != nil) {
        return _hideSettingButton;
    }
    _hideSettingButton = [[NSUserDefaults standardUserDefaults] valueForKey:HP_HIDE_SETTING_BUTTON];
    return _hideSettingButton?:@(NO);
}

- (void)setHideSettingButton:(NSNumber *)hideSettingButton
{
    if ([_hideSettingButton isEqualToNumber:hideSettingButton]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:hideSettingButton forKey:HP_HIDE_SETTING_BUTTON];
    _hideSettingButton = hideSettingButton;
}

#pragma mark - PersonalKey
- (NSString *)personalKey
{
    if (_personalKey != nil) {
        return _personalKey;
    }
    _personalKey = [[NSUserDefaults standardUserDefaults] valueForKey:HP_PERSONAL_KEY];
    return _personalKey?:@"example";
}

- (void)setPersonalKey:(NSString *)personalKey
{
    if ([_personalKey isEqualToString:personalKey]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:personalKey forKey:HP_PERSONAL_KEY];
    _personalKey = personalKey;
}

#pragma mark - HashType
- (NSString *)hashType
{
    if (_hashType != nil) {
        return _hashType;
    }
    _hashType = [[NSUserDefaults standardUserDefaults] valueForKey:HP_HASH_TYPE];
    return _hashType?:HP_HASH_MD5;
}

- (void)setHashType:(NSString *)hashType
{
    if ([_hashType isEqualToString:hashType]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:hashType forKey:HP_HASH_TYPE];
    _hashType = hashType;
}

#pragma mark - HahsTimes
- (NSNumber *)hashTimes
{
    if (_hashTimes != nil) {
        return _hashTimes;
    }
    _hashTimes = [[NSUserDefaults standardUserDefaults] valueForKey:HP_HASH_TIMES];
    return _hashTimes?:@1;
}

- (void)setHashTimes:(NSNumber *)hashTimes
{
    if ([_hashTimes isEqualToNumber:hashTimes]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:hashTimes forKey:HP_HASH_TIMES];
    _hashTimes = hashTimes;
}

#pragma mark - PasswordLength
- (NSNumber *)passwordLength
{
    if (_passwordLength != nil) {
        return _passwordLength;
    }
    _passwordLength = [[NSUserDefaults standardUserDefaults] valueForKey:HP_PASSWORD_LENGTH];
    return _passwordLength?:@12;
}

- (void)setPasswordLength:(NSNumber *)passwordLength
{
    if ([_passwordLength isEqualToNumber:passwordLength]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:passwordLength forKey:HP_PASSWORD_LENGTH];
    _passwordLength = passwordLength;
}

#pragma mark - CaseMixed
- (NSNumber *)caseMixed
{
    if (_caseMixed != nil) {
        return _caseMixed;
    }
    _caseMixed = [[NSUserDefaults standardUserDefaults] valueForKey:HP_CASE_MIXED];
    return _caseMixed?:@(YES);
}

- (void)setCaseMixed:(NSNumber *)caseMixed
{
    if ([_caseMixed isEqualToNumber:caseMixed]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:caseMixed forKey:HP_CASE_MIXED];
    _caseMixed = caseMixed;
}

#pragma mark - SendToClipboard
- (NSNumber *)sendToClipboard
{
    if (_sendToClipboard != nil) {
        return _sendToClipboard;
    }
    _sendToClipboard = [[NSUserDefaults standardUserDefaults] valueForKey:HP_SEND_TO_CLIPBOARD];
    return _sendToClipboard?:@(YES);
}

- (void)setSendToClipboard:(NSNumber *)sendToClipboard
{
    if ([_sendToClipboard isEqualToNumber:sendToClipboard]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:sendToClipboard forKey:HP_SEND_TO_CLIPBOARD];
    _sendToClipboard = sendToClipboard;
}

#pragma mark - SendNotification
- (NSNumber *)sendNotification
{
    if (_sendNotification != nil) {
        return _sendNotification;
    }
    _sendNotification = [[NSUserDefaults standardUserDefaults] valueForKey:HP_SEND_NOTIFICATION];
    return _sendNotification?:@(NO);
}

- (void)setSendNotification:(NSNumber *)sendNotification
{
    if ([_sendNotification isEqualToNumber:sendNotification]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:sendNotification forKey:HP_SEND_NOTIFICATION];
    _sendNotification = sendNotification;
}

#pragma mark - 
- (NSArray<NSString *> *)allSupportHashType
{
    return @[HP_HASH_MD5,
             HP_HASH_SHA1,
             HP_HASH_SHA224,
             HP_HASH_SHA256,
             HP_HASH_SHA384,
             HP_HASH_SHA512];
}


@end
