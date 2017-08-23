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
@property (copy , nonatomic) NSString *xmppPassword;

@end

@implementation XMPPManager

static XMPPManager *manager = nil;

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
        [self.stream setHostName:@"192.168.0.103"];
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
    self.xmppPassword = password;       // 记录密码
    [self.stream setMyJID:jid];         // 设置当前用户
    // 连接openfire服务器
    [self.stream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
}

#pragma mark - XMPPStreamDelegate

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    // 连接成功就登录
    XMPPLog(@"Openfire服务器连接成功!");
    
    // 登录
    [self.stream authenticateWithPassword:self.xmppPassword error:nil];
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    // 连接失败
    XMPPLog(@"Openfire服务器连接失败:%@", error);
    // 回调
    if (self.xmppConnectBlock)
    {
        self.xmppConnectBlock(sender, error);
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    // 登录成功
    XMPPLog(@"账号登录成功!");
    // 回调
    if (self.xmppConnectBlock)
    {
        self.xmppConnectBlock(sender, nil);
    }
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    // 登录失败
    XMPPLog(@"账号登录失败:%@ %@", error.name, error.stringValue);
    // 注册账号
    [self.stream registerWithPassword:self.xmppPassword error:nil];
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    // 注册成功
    XMPPLog(@"账号注册成功!");
    // 登录账号
    [self.stream authenticateWithPassword:self.xmppPassword error:nil];
}


@end




