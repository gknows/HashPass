//
//  HashPassGenerater.m
//  HashPass
//
//  Created by HJ on 5/19/16.
//  Copyright © 2016 gknows. All rights reserved.
//

#import "HashPassGenerater.h"
#import "HashPassSettingManager.h"
#import <CommonCrypto/CommonDigest.h>

typedef unsigned char *(*HP_HASH_FUNC)(const void *data, CC_LONG len, unsigned char *md);

@implementation HashPassGenerater

+ (NSString *)generatePassword:(NSString *)input;
{
    HashPassSettingManager *setting = [HashPassSettingManager sharedManager];
    NSString *text = [setting.personalKey stringByAppendingString:input];
   
    text = [HashPassGenerater doHash:text];
    text = [text substringToIndex:[setting.passwordLength intValue]];
    return text;
}

+ (NSString *)doHash:(NSString *)input
{
    NSString *hashType = [HashPassSettingManager sharedManager].hashType;
    NSString *output;
    HP_HASH_FUNC hashFunc;
    int digestLength = 0;
    if ([hashType isEqualToString:HP_HASH_MD5]) {
        hashFunc = CC_MD5;
        digestLength = CC_MD5_DIGEST_LENGTH;
    } else if ([hashType isEqualToString:HP_HASH_SHA1]) {
        hashFunc = CC_SHA1;
        digestLength = CC_SHA1_DIGEST_LENGTH;
    } else if ([hashType isEqualToString:HP_HASH_SHA224]) {
        hashFunc = CC_SHA224;
        digestLength = CC_SHA224_DIGEST_LENGTH;
    } else if ([hashType isEqualToString:HP_HASH_SHA256]) {
        hashFunc = CC_SHA256;
        digestLength = CC_SHA256_DIGEST_LENGTH;
    } else if ([hashType isEqualToString:HP_HASH_SHA384]) {
        hashFunc = CC_SHA384;
        digestLength = CC_SHA384_DIGEST_LENGTH;
    } else if ([hashType isEqualToString:HP_HASH_SHA512]) {
        hashFunc = CC_SHA512;
        digestLength = CC_SHA512_DIGEST_LENGTH;
    } else {
        return input;
    }
    output = [HashPassGenerater hash:hashFunc length:digestLength input:input];
    //NSLog(@"hash: %@", output);
    return output;
}

#pragma mark - Private
+ (NSString *)hash:(HP_HASH_FUNC)hashFunc length:(int)len input:(NSString *)input
{
    HashPassSettingManager *setting = [HashPassSettingManager sharedManager];
    int times = [setting.hashTimes intValue];
    BOOL mixed = [setting.caseMixed boolValue];
    const char *cString = [input UTF8String];
    unsigned char digest[len];
    
    char buffer[len*2];
    while (times--) {
        hashFunc(cString, (CC_LONG)strlen(cString), digest);
        for (int i=0; i<len; i++) {
            char *format = "%02x";
            if (mixed && (i%2==0)) {
                format = "%02X";
            }
            sprintf(&buffer[i*2],format,digest[i]);
        }
        cString = buffer;
    }
    NSString *output = [NSString stringWithUTF8String:cString];
    return output;
}

@end
