//
//  IMUser.m
//  xmpp_im
//
//  Created by winter on 2017/8/22.
//  Copyright © 2017年 laidongling. All rights reserved.
//

#import "IMUser.h"
#import <XMPPFramework/XMPPJID.h>

@implementation IMUser

+ (instancetype)imUserWithUserId:(NSString *)userId name:(NSString *)name logo:(NSString *)logo
{
    return [[self alloc] initWithUserId:userId name:name logo:logo];
}

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)name logo:(NSString *)logo
{
    if (self = [super init])
    {
        self.userId = userId;
        self.name = name;
        self.logo = logo;
    }
    
    return self;
}

- (XMPPJID *)toXmppJid
{
    return [XMPPJID jidWithUser:self.userId domain:@"im.com" resource:self.logo];
}


@end
