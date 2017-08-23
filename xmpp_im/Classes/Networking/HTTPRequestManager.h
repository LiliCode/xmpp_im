//
//  HTTPRequestManager.h
//  GAIA供应
//
//  Created by winter on 2017/8/21.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "URLCreator.h"

/**
 HTTP请求数据回调
 
 @param task session data tesk
 @param data 返回的数据，如果请求失败或者请求错误均返回nil
 @param error 响应成功返回nil
 */
typedef void (^HTTPRequestCallback)(NSURLSessionDataTask * task, id data, NSError * error);

@interface HTTPRequestManager : NSObject<NSCopying, NSMutableCopying>
/** AFN manager , 该属性为只读*/
@property (strong , nonatomic, readonly) AFHTTPSessionManager *sessionManager;

/**
 创建一个HTTP请求管理器
 
 @return manager
 */
+ (instancetype)sharedManager;

/**
 GET请求
 
 @param url 请求链接
 @param completion 请求完成的回调
 @return 返回 NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)get:(NSString *)url completion:(HTTPRequestCallback)completion;

/**
 普通POST请求
 
 @param url 请求链接
 @param completion 请求完成的回调
 @return 返回 NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters completion:(HTTPRequestCallback)completion;

/**
 带流的POST请求
 
 @param url 请求链接
 @param parameters 拼接在body中的参数,也就是需要post的参数
 @param formatDataBlock 拼接流的回调,在这个回调中上传资源(例如:图片,音频)
 @param completion 请求完成的回调
 @return 返回 NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)post:(NSString *)url parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formatData))formatDataBlock completion:(HTTPRequestCallback)completion;


@end


