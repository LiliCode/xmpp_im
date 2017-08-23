//
//  UIFont+Extension.h
//  linlin2
//
//  Created by LiliEhuu on 17/8/2.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extension)

/**
 PingFang SC 字体，如果系统不支持改字体就是用默认字体

 @param fontSize 字体大小
 @return 返回该字体对象
 */
+ (UIFont *)pingFangSCFontOfSize:(CGFloat)fontSize;


@end
