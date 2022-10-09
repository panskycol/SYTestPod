//
//  SYHttpHelper.m
//  TPFBasicSDK
//
//  Created by 呼啦 on 2022/8/3.
//  Copyright © 2022 尚游网络. All rights reserved.
//

#import "SYHttpHelper.h"

@implementation SYHttpHelper

+ (void)monitorNetWorkStatus:(void (^)(AFNetworkReachabilityStatus))workStatus{
    
    [SYHttpManager monitorNetWorkStatus:workStatus];
}

+ (AFNetworkReachabilityStatus)currentNetworkStatus{
    
    return [SYHttpManager currentNetworkStatus];
}

#pragma mark - GET
+ (void)getRequestWithUrl:(NSString *)urlStr
                   params:(NSDictionary *)params
                  headers:(NSDictionary *)headers
                  success:(void (^)(NSDictionary * _Nonnull, int))success
                  failure:(void (^)(NSDictionary * _Nonnull, int))failure{
    
    [SYHttpManager httpGetRequestWithUrl:urlStr params:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self dealWithSuccessResultWithResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"--->GET请求失败，error:%@;\n request:%@;\n response:%@", error, task.originalRequest, task.response);
        NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(error.code), @"code", error.description, @"msg", nil];
        if (failure) failure(dataDict, (int)error.code);
    }];
}

+ (void)getRequestWithUrl:(NSString *)urlStr
                   params:(NSDictionary *)params
                  headers:(NSDictionary *)headers
            retryInterval:(NSInteger)interval
               retryTimes:(NSInteger)retryTimes
                  success:(void (^)(NSDictionary * _Nonnull, int))success
                  failure:(void (^)(NSDictionary * _Nonnull, int))failure{
    
    [SYHttpManager httpGetRequestWithUrl:urlStr params:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self dealWithSuccessResultWithResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        if (retryTimes > 0) {
            NSLog(@"--->GET请求失败, 网络错误, 3秒后重新尝试");
            // 如果重试次数大于0, 则在3秒后重试
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getRequestWithUrl:urlStr params:params headers:headers retryInterval:interval retryTimes:retryTimes-1 success:success failure:failure];
            });
        }else{
            NSLog(@"--->GET请求失败，error:%@;\n request:%@;\n response:%@", error, task.originalRequest, task.response);
            NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(error.code), @"code", error.description, @"msg", nil];
            if (failure) failure(dataDict, (int)error.code);
        }
    }];
}


#pragma mark - POST
+ (void)postRequestWithUrl:(NSString *)urlStr
                    params:(NSDictionary *)params
                   headers:(NSDictionary *)headers
                   success:(void (^)(NSDictionary * _Nonnull, int))success
                   failure:(void (^)(NSDictionary * _Nonnull, int))failure{
    
    [SYHttpManager httpPostRequestWithUrl:urlStr params:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self dealWithSuccessResultWithResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"--->GET请求失败，error:%@;\n request:%@;\n response:%@", error, task.originalRequest, task.response);
        NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(error.code), @"code", error.description, @"msg", nil];
        if (failure) failure(dataDict, (int)error.code);
    }];
}

+ (void)postRequestWithUrl:(NSString *)urlStr
                    params:(NSDictionary *)params
                   headers:(NSDictionary *)headers
             retryInterval:(NSInteger)interval
                retryTimes:(NSInteger)retryTimes
                   success:(void (^)(NSDictionary * _Nonnull, int))success
                   failure:(void (^)(NSDictionary * _Nonnull, int))failure{
    
    [SYHttpManager httpPostRequestWithUrl:urlStr params:params headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self dealWithSuccessResultWithResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        if (retryTimes > 0) {
            NSLog(@"--->POST请求失败, 网络错误, 3秒后重新尝试");
            
            // 如果重试次数大于0, 则在3秒后重试
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self postRequestWithUrl:urlStr params:params headers:headers retryInterval:interval retryTimes:retryTimes-1 success:success failure:failure];
            });
        }else{
            NSLog(@"--->POST请求失败，error:%@;\n request:%@;\n response:%@", error, task.originalRequest, task.response);
            NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(error.code), @"code", error.description, @"msg", nil];
            if (failure) failure(dataDict, (int)error.code);
        }
    }];
}

#pragma mark - 公共方法
/// 处理成功响应
+ (void)dealWithSuccessResultWithResponse:(NSData *)responseObject success:(void (^)(NSDictionary * _Nonnull, int))success failure:(void (^)(NSDictionary * _Nonnull, int))failure{
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    
    // 这里只查找到二级的结构，不进行递归查找, 出现超过二级的code，使用的地方自行解决
    NSString *resultCode = [self getResultCode:response];
    int code = resultCode?resultCode.intValue:MAXFLOAT;

    // 数据解析失败，或者数据为空，请求失败
    if ([NSObject isNullDictonary:response]) {
        NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@(code), @"code", @"未知错误", @"msg", nil];
        if (failure) failure(dataDict, code);
        return;
    }
    
    if (code < 0) {
        if (failure) failure(response, code);
        return;
    }
    
    if (success) {
        success(response, code);
    }
}


/// 获取字符串里面的状态码
/// @param response 响应字典
+ (NSString *)getResultCode:(NSDictionary *)response{
    
    __block NSString *code = [self getCodeString:response];
    if (code) {
        return code;
    }
    
    // 遍历
    [response enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
        if([obj isKindOfClass:[NSDictionary class]]){
            
            code = [self getCodeString:obj];
        }
        
        if (code) {
            *stop = YES;
        }
    }];
    
    return code;
}

+ (NSString *)getCodeString:(NSDictionary *)info{
    NSString *code = [[info objectForKey:@"errorCode"] description];
    if (!code) {
        code = [[info objectForKey:@"ErrorCode"] description];
    }
    if (!code) {
        code = [[info objectForKey:@"errCode"] description];
    }
    if (!code) {
        code = [[info objectForKey:@"retcode"] description];
    }
    return code;
}

@end
