//
//  IMUser.h
//  xmpp_im
//
//  Created by winter on 2017/8/22.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMPPJID;

@interface IMUser : NSObject
/** 用户名 */
@property (copy , nonatomic) NSString *name;
/** 用户id */
@property (copy , nonatomic) NSString *userId;
/** 用户头像 */
@property (copy , nonatomic) NSString *logo;

/**
 IMUser实例对象
 
 @param userId 用户的id
 @param name 用户名
 @param logo 用户头像
 @return 返回一个IMUser对象
 */
+ (instancetype)imUserWithUserId:(NSString *)userId name:(NSString *)name logo:(NSString *)logo;

/**
 转换成XMPPJID对象
 
 @return 返回一个XMPPJID对象
 */
- (XMPPJID *)toXmppJid;

@end
