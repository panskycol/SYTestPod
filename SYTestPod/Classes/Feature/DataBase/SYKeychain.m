//
//  SYKeychain.m
//  TPFBasicSDK
//
//  Created by 呼啦 on 2022/8/22.
//  Copyright © 2022 尚游网络. All rights reserved.
//

#import "SYKeychain.h"
#import "SYDBConstants.h"

@implementation SYKeychain

+ (void)saveValue:(NSString *)value forkey:(NSString *)key{
    
    [SAMKeychain setPassword:value forService:KEYCHAIN_NORMAL_SERVICE_NAME account:key];
}

+ (void)deleteValueForKey:(NSString *)key{
    
    [SAMKeychain deletePasswordForService:KEYCHAIN_NORMAL_SERVICE_NAME account:key];
}

+ (void)saveData:(NSData *)data forkey:(NSString *)key{
    
    [SAMKeychain setPasswordData:data forService:KEYCHAIN_NORMAL_SERVICE_NAME account:key];
}

@end
