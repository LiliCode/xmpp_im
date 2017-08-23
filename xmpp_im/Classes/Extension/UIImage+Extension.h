//
//  UIImage+Extension.h
//  linlin2
//
//  Created by LiliEhuu on 17/3/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger , UIImageFormat)
{
    UIImageFormat_JPEG,
    UIImageFormat_PNG,
    UIImageFormat_GIF,
    UIImageFormat_TIFF,
    UIImageFormat_other
};


@interface UIImage (Extension)

/**
 获取图片格式

 @param data 图片Data
 @return 返回格式枚举值
 */
+ (UIImageFormat)typeForImageData:(NSData *)data;

/**
 获取类型扩展名

 @param type 类型枚举值
 @return 类型扩展名
 */
+ (NSString *)typeName:(UIImageFormat)type;


/**
 使改图片模糊

 @param radius 模糊半径
 @param iterations 迭代次数
 @param tintColor 色调
 @return 返回图片
 */
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

/**
 生成张纯色的图片

 @param color 颜色
 @param size 尺寸大小
 @param alpha 透明度
 @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

@end




