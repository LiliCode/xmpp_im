//
//  UIAlertView+Response.m
//  UIAlert+Response
//
//  Created by LiliEhuu on 16/9/23.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "UIAlertView+Response.h"
#import <objc/runtime.h>

@interface UIAlertView ()<UIAlertViewDelegate>
@property (copy , nonatomic) ResponseUsingBlock responseUsingBlock;

@end

@implementation UIAlertView (Response)

static char *responseBlockKey = "responseBlockKey";

- (void)setResponseUsingBlock:(ResponseUsingBlock)responseUsingBlock
{
    objc_setAssociatedObject(self, responseBlockKey, responseUsingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ResponseUsingBlock)responseUsingBlock
{
    return objc_getAssociatedObject(self, responseBlockKey);
}


- (void)showAlertCompleteHandler:(ResponseUsingBlock)responseBlock
{
    self.delegate = self;
    self.responseUsingBlock = responseBlock;
    [self show];
}

- (void)clearHandler
{
    self.delegate = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.responseUsingBlock)
    {
        __weak typeof(self) weakSelf = self;
        self.responseUsingBlock(weakSelf, buttonIndex);
    }
}



@end
