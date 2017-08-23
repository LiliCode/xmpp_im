//
//  NSObject+Extension.m
//  linlin2
//
//  Created by LiliEhuu on 17/2/24.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)


- (id)nonull
{
    //如果该对象是NSNull的对象,就返回nil
    if ([self isMemberOfClass:[NSNull class]])
    {
        return nil;
    }
    
    return self;
}


@end
