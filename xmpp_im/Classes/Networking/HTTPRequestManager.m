//
//  HTTPRequestManager.m
//  GAIA供应
//
//  Created by winter on 2017/8/21.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "HTTPRequestManager.h"

@interface HTTPRequestManager ()
@property (strong , nonatomic) AFHTTPSessionManager *httpManager;

@end

@implementation HTTPRequestManager

- (AFHTTPSessionManager *)sessionManager
{
    return self.httpManager;
}

static HTTPRequestManager *manager = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.httpManager = [AFHTTPSessionManager manager];
        [manager config];   // 配置
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t allocToken;
    dispatch_once(&allocToken, ^{
        manager = [super allocWithZone:zone];
    });
    
    return manager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return manager;
}

/**
 AFHTTPSesstionManager 配置
 */
- (void)config
{
    //自己配置
    //请求序列化
    AFJSONRequestSerializer *serializerRequest = [AFJSONRequestSerializer serializer];
    //    [serializerRequest setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [serializerRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [serializerRequest setValue:@"ios" forHTTPHeaderField:@"OS"];
    [serializerRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //响应序列化
    AFJSONResponseSerializer *serializerResponse = [AFJSONResponseSerializer serializer];
    serializerResponse.removesKeysWithNullValues = YES; //过滤NSNull对象，即<null>
    serializerResponse.readingOptions = NSJSONReadingAllowFragments;
    //Add @'text/html' and 'application/json' for 'acceptableContentTypes'.
    serializerResponse.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", nil];
#if SSL_PINNING_MODE
    //https 需要的证书 安全策略
    self.httpManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //读取证书 注意：证书名称自拟
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https_certificate" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    self.httpManager.securityPolicy.pinnedCertificates = @[cerData];
    //客户端是否信任非法证书
    self.httpManager.securityPolicy.allowInvalidCertificates = YES;
    //是否在证书域字段中验证域名
    [self.httpManager.securityPolicy setValidatesDomainName:NO];
#else
    //安全策略 无安全策略 http
    self.httpManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
#endif
    //设置请求序列化
    [self.httpManager setRequestSerializer:serializerRequest];
    //设置响应序列化
    [self.httpManager setResponseSerializer:serializerResponse];
    //设置请求超时时间
    [self.httpManager.requestSerializer setTimeoutInterval:30];
}

#pragma mark - 请求方法的实现

- (NSURLSessionDataTask *)get:(NSString *)url completion:(HTTPRequestCallback)completion
{
    return [self.httpManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion)
        {
            NSError *error = nil;
            NSDictionary *result = [self parseResponse:responseObject domain:task.response.URL.absoluteString error:&error];
            completion(task, result, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
        {
            completion(task, nil, error);
        }
    }];
}

- (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters completion:(HTTPRequestCallback)completion
{
    return [self.httpManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion)
        {
            NSError *error = nil;
            NSDictionary *result = [self parseResponse:responseObject domain:task.response.URL.absoluteString error:&error];
            completion(task, result, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
        {
            completion(task, nil, error);
        }
    }];
}

- (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))formatDataBlock completion:(HTTPRequestCallback)completion
{
    return [self.httpManager POST:url parameters:parameters constructingBodyWithBlock:formatDataBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion)
        {
            NSError *error = nil;
            NSDictionary *result = [self parseResponse:responseObject domain:task.response.URL.absoluteString error:&error];
            completion(task, result, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
        {
            completion(task, nil, error);
        }
    }];
}


/**
 解析服务器返回的数据
 
 @param responseObject 数据字典
 @param domain 主机名称
 @param error 错误信息
 @return 返回可用的数据，如果错误则返回nil
 */
- (NSDictionary *)parseResponse:(id)responseObject domain:(NSErrorDomain)domain error:(NSError **)error
{
    NSMutableDictionary *info = [responseObject mutableCopy];
#warning 根据后端返回数据的格式来解析
    if (![info[@"message"] isEqualToString:@"SUCCEED"])
    {
        NSString *domainUrl = [[domain componentsSeparatedByString:@"?"] firstObject];
        *error = [NSError errorWithDomain:domainUrl code:0 userInfo:@{NSLocalizedDescriptionKey : info[@"errorData"][@"message"]?:@""}];
        return nil;
    }
    
    //删除无用信息
    [info removeObjectForKey:@"message"];
    [info removeObjectForKey:@"code"];
    //返回结果
    return [info copy];
}


@end





