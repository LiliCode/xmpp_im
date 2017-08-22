//
//  XMPPManager.h
//  xmpp_im
//
//  Created by winter on 2017/8/22.
//  Copyright © 2017年 Lili. All rights reserved.
//
//  参考资料: http://www.cocoachina.com/ios/20141219/10703.html
//

#import <Foundation/Foundation.h>
#import <XMPPFramework/XMPP.h>

/** Openfire连接的回调 */
typedef void (^XMPPConnectCallback)(XMPPStream *xmppStream, NSError *error);

@interface XMPPManager : NSObject<NSCopying, NSMutableCopying>
/** xmpp stream 对象 */
@property (strong , nonatomic , readonly) XMPPStream *xmppStream;
/** XMPP代理队列 */
@property (assign , nonatomic , readonly) dispatch_queue_t xmppQueue;

/**
 创建一个全局对象
 
 @return 返回静态实例
 */
+ (instancetype)sharedManager;

/**
 连接openfire服务器
 
 @param jid 需要连接的账号
 @param password 密码
 */
- (void)connectWithJID:(XMPPJID *)jid password:(NSString *)password completion:(XMPPConnectCallback)completion;

/**
 断开连接
 */
- (void)disconnect;


@end




