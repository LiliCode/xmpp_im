//
//  UIAlertView+Extension.m
//  LinFoundation
//
//  Created by LiliEhuu on 17/2/6.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIAlertView+Extension.h"

@implementation UIAlertView (Extension)


+ (instancetype)alert:(NSString *)msg
{
    if (!msg.length)
    {
        return nil;
    }
    
    return [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
}


@end
