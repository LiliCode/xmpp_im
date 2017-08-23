//
//  URLCreator.h
//  GAIA供应
//
//  Created by winter on 2017/8/21.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLCreator : NSObject

@property (copy , nonatomic) NSString *baseURLString;   //基地址

/**
 构建器
 
 @return 返回构建器实例
 */
+ (instancetype)creator;

/**
 URL构建器
 
 @param apiName 接口API名称
 @param parmsDic url的参数
 @param encoding 是否需要编码
 @return 返回完整的url链接字符串
 */
- (nonnull NSString *)urlCreatorWithAPIName:(nonnull NSString *)apiName parms:(NSDictionary *)parmsDic encoding:(BOOL)encoding;

/**
 解析链接中的参数
 
 @param url 链接字符串
 @return 返回解析之后的参数字典
 */
- (NSDictionary *)parseParameters:(NSString *)url;

@end
