//
//  ServerManager.h
//  GAIA供应
//
//  Created by winter on 2017/8/20.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 生产环境和测试环境切换
 ----备注：1 开启生产环境、 0 关闭生产环境，进入到测试环境
 */
#define OPEN_PRODUCT (1)

/**
 开启HTTPS安全模式
 
 @param 0 参数：0关闭，1开启
 */
#define SSL_PINNING_MODE (0)
//http请求前缀 SSL_PINNING_MODE == 1 时就是 https
FOUNDATION_EXPORT NSString *const HTTP_PROFIX;

/** 服务器根路径 */
#define SERVER_HOST_ROOT [ServerManager sharedManager].path
/** 资源服务器根路径 */
#define SERVER_ASSETS_ROOT [ServerManager sharedManager].assetPath


@interface ServerManager : NSObject<NSCopying, NSMutableCopying>
/** 服务器主机地址 */
@property (copy , nonatomic) NSString *path;
/** 资源服务器地址 */
@property (copy , nonatomic) NSString *assetPath;
/** HTML地址 */
@property (copy , nonatomic) NSString *htmlPath;

/**
 静态实例
 
 @return 返回当前类的静态实例
 */
+ (instancetype)sharedManager;

/** 动态获取服务器地址 */
- (void)getServerPath;

@end




