//
//  TPFBasicConfig.m
//  TPFBasicSDK
//
//  Created by 呼啦 on 2022/8/23.
//  Copyright © 2022 尚游网络. All rights reserved.
//

#import "TPFBasicConfig.h"
#import "TPFBasicMacro.h"

@implementation TPFBasicConfig

+ (instancetype)shareInstance{
    static TPFBasicConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[TPFBasicConfig alloc] init];
    });
    return config;
}

- (void)setConfigInfo{
    
    NSDictionary *basicSDK = [self getConfigData];
    if (basicSDK){
        self.appId = basicSDK[@"APPID"];
        self.channelId = basicSDK[@"CHANNELID"];
        self.appSecret = basicSDK[@"APPSECRET"];
        self.appKey = basicSDK[@"APPKEY"];
        self.eventAppKey = basicSDK[@"EVENT_APPKEY"];
        if([basicSDK objectForKey:@"PROXY"])
        {
            self.proxy = basicSDK[@"PROXY"];
        }else{
            self.proxy = BASIC_UNIFY_DOMAIN;
        }
        if([basicSDK objectForKey:@"URL_DATA_REPORT"])
        {
            self.dataReportUrl = basicSDK[@"URL_DATA_REPORT"];
        }else{
            self.dataReportUrl = BASIC_DATA_REPORT;
        }
        if ([basicSDK objectForKey:@"SERVERID"]) {
            self.regionIndex = basicSDK[@"SERVERID"];
        }else{
            self.regionIndex = BASIC_UNIFY_NAMESPACE;
        }
        
        NSLog(@"basicSDK.Config : %@",basicSDK);
    }
}


///获取APPKey
- (NSDictionary *)getConfigData{

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *pathStr = [bundle pathForResource:@"TPFBasicKey.bundle/TPFBasicKey" ofType:@"plist"];
    NSDictionary *dictKey = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    NSLog(@"getConfigData===%@",dictKey);
    return dictKey;
}

@end
