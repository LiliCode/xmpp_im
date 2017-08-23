//
//  ServerManager.m
//  GAIA供应
//
//  Created by winter on 2017/8/20.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "ServerManager.h"

//HTTP请求链接前缀
#if SSL_PINNING_MODE
//开启了https安全模式
NSString * const HTTP_PROFIX = @"https://";
#else
//未开启安全模式，使用http
NSString * const HTTP_PROFIX = @"http://";
#endif


#if OPEN_PRODUCT

NSString *const PRODUCT_SERVER_PATH = @"www.gaia.com/";
NSString *const PRODUCT_ASSET_PATH = @"www.gaia.com/img/";
NSString *const PRODUCT_HTML_PATH = @"www.gaia.com/web/";

#else

NSString *const PRODUCT_SERVER_PATH = @"www.gaia.com/";
NSString *const PRODUCT_ASSET_PATH = @"www.gaia.com/img/";
NSString *const PRODUCT_HTML_PATH = @"www.gaia.com/web/";

#endif


@interface ServerManager ()

@end

@implementation ServerManager

#pragma mark - 初始化

static ServerManager *manager = nil;

+ (instancetype)sharedManager
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[self alloc] init];
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

- (instancetype)init
{
    if (self = [super init])
    {
        // 初始化服务器地址
        self.path = PRODUCT_SERVER_PATH;
        self.assetPath = PRODUCT_ASSET_PATH;
        self.htmlPath = PRODUCT_HTML_PATH;
    }
    
    return self;
}

#pragma mark - 业务

- (void)getServerPath
{
    // 获取服务器地址...
    GALog(@"获取服务器地址...");
}




@end





