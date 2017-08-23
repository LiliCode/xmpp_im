//
//  URLCreator.m
//  GAIA供应
//
//  Created by winter on 2017/8/21.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "URLCreator.h"

@implementation URLCreator

+ (instancetype)creator
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.baseURLString = SERVER_HOST_ROOT;
    }
    
    return self;
}

- (NSString *)urlCreatorWithAPIName:(NSString *)apiName parms:(NSDictionary *)parmsDic encoding:(BOOL)encoding
{
    NSAssert(apiName, @"链接名称不能为空!");
    //以邻邻项目为准
    NSString *appdParms = [apiName stringByAppendingString:@""]; //拼接拦截器参数
    NSMutableArray *keyValueStringList = [[NSMutableArray alloc] init];
    if (parmsDic)
    {
        for (NSString *key in parmsDic.allKeys)
        {
            id anyObject = [parmsDic objectForKey:key];
            NSString *value = anyObject;
            if ([anyObject isKindOfClass:[NSArray class]])
            {
                //解析数组-解析成字符串，元素以","链接
                NSString *arrayString = [[NSString alloc] init];
                NSUInteger elementCount = 0;
                for (id element in anyObject)
                {
                    arrayString = [arrayString stringByAppendingString:element];
                    if (++elementCount != [anyObject count])
                    {
                        arrayString = [arrayString stringByAppendingString:@","];
                    }
                }
                
                value = [arrayString copy];
            }
            
            //添加参数字符串
            [keyValueStringList addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
    }
    
    //拼接
    NSString *absURLString = [appdParms stringByAppendingString:[keyValueStringList componentsJoinedByString:@"&"]];
    NSString *url = [self.baseURLString stringByAppendingString:absURLString];
    if (encoding)
    {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    //打印链接
    NSLog_debug(@"请求接口: %@", url);
    
    return url;
}

- (NSDictionary *)parseParameters:(NSString *)url
{
    if (!url.length)
    {
        return nil;
    }
    
    NSArray *apiNames = [url componentsSeparatedByString:@"?"];
    NSArray *pars = [[apiNames lastObject] componentsSeparatedByString:@"&"];
    NSMutableDictionary *keyValues = [[NSMutableDictionary alloc] init];
    for (NSString *p in pars)
    {
        NSArray *keyValue = [p componentsSeparatedByString:@"="];
        [keyValues setObject:keyValue.lastObject forKey:keyValue.firstObject];
    }
    
    return [keyValues copy];
}

@end
