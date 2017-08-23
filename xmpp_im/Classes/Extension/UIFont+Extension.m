//
//  UIFont+Extension.m
//  linlin2
//
//  Created by LiliEhuu on 17/8/2.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+ (UIFont *)pingFangSCFontOfSize:(CGFloat)fontSize
{
    UIFont *font = [UIFont fontWithName:@"PingFang SC" size:fontSize];
    // 如果系统不支持改字体，就是用系统默认字体
    if (!font)
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

@end
