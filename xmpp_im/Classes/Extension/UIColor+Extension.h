//
//  UIColor+Extension.h
//  LinFoundation
//
//  Created by LiliEhuu on 17/2/6.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>



FOUNDATION_EXTERN_INLINE UIColor *UIColorHex(const char *hexValue, CGFloat alpha);


@interface UIColor (Extension)


/**
 十六进制颜色
 
 @param hexValue 十六进制颜色字符串，例如：#F2F2EC
 @param alpha 透明通道
 @return 返回相应颜色值
 */
+ (UIColor *)hexColor:(NSString *)hexValue alpha:(CGFloat)alpha;


/**
 十六进制颜色

 @param hexValue 十六进制颜色字符串，例如：#F2F2EC
 @param alpha 透明通道
 @return 返回相应颜色值
 */
+ (UIColor *)colorWithHexValue:(NSString*)hexValue alpha:(CGFloat)alpha;

/**
 *  三基色
 */
+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpha:(CGFloat)alpha;

@end
