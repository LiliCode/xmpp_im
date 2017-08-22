//
//  XMPPManager.m
//  xmpp_im
//
//  Created by winter on 2017/8/22.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "XMPPManager.h"

@interface XMPPManager ()<XMPPStreamDelegate>
@property (strong , nonatomic) XMPPStream *stream;
@property (copy , nonatomic) XMPPConnectCallback xmppConnectBlock;

@end

@implementation XMPPManager

static XMPPManager *manager;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
        // 创建一个xmpp stream
        self.stream = [[XMPPStream alloc] init];
        // 设置代理对象和执行代理方法的队列
        [self.stream addDelegate:self delegateQueue:self.xmppQueue];
        // 设置主机名
        [self.stream setHostName:@"192.168.0.104"];
        // 设置端口号
        [self.stream setHostPort:5222];
    }
    
    return self;
}

- (XMPPStream *)xmppStream
{
    return self.stream;
}

- (dispatch_queue_t)xmppQueue
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)disconnect
{
    // 执行断开连接
    if ([self.stream isConnected])  // 判断是否已经连接
    {
        [self.stream disconnect];
    }
}

- (void)connectWithJID:(XMPPJID *)jid password:(NSString *)password completion:(XMPPConnectCallback)completion
{
    self.xmppConnectBlock = completion; // 回调
    [self.stream setMyJID:jid];         // 设置当前用户
    [self.stream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
}

#pragma mark - XMPPStreamDelegate

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    // 连接成功就登录
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    if (self.xmppConnectBlock)
    {
        self.xmppConnectBlock(sender, error);
    }
}





@end




