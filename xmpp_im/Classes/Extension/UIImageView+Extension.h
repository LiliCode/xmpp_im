//
//  UIImageView+Extension.h
//  LinFoundation
//
//  Created by LiliEhuu on 17/2/4.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 App每张图片大小的类型

 - LinImageSize_full: 原图
 - LinImageSize_large: 高清图
 - LinImageSize_thumbnail: 缩略图
 */
typedef NS_ENUM(NSUInteger, LinImageSize)
{
    LinImageSize_thumbnail,
    LinImageSize_large,
    LinImageSize_full
};


@interface NSString (INCreator)

/**
 原图尺寸名称

 @return 返回full_name
 */
- (NSString *)full;

/**
 高清图尺寸名称

 @return 返回large_name
 */
- (NSString *)large;

/**
 缩略图尺寸名称

 @return 返回thumbnail_name
 */
- (NSString *)thumbnail;

@end

@interface UIImageView (Extension)


/**
 设置圆形图片

 @param image 原图
 */
- (void)setCircleImage:(UIImage *)image;

/**
 设置圆形图片并描边

 @param image 原图
 @param width 描边宽度
 @param color 描边颜色
 */
- (void)setCircleImage:(UIImage *)image borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 加载网络图片

 @param url 图片链接或名称
 @param imageSize 图片的尺寸
 @param completion 图片加载完成之后的回调
 */
- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize completion:(void (^)(UIImage *image, NSString *imageUrl))completion;

/**
 加载网络图片

 @param url 图片链接或名称
 @param imageSize 图片的尺寸
 @param pImage 自定义的占位图
 @param completion 图片加载完成之后的回调
 */
- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize placeholderImage:(UIImage *)pImage completion:(void (^)(UIImage *image, NSString *imageUrl))completion;

/**
 加载网络图片并圆角

 @param url 图片链接或者名称
 @param imageSize 图片大小
 @param cornerRadius 圆角半径
 @param width 描边的宽度
 @param color 描边的颜色
 @param completion 图片加工完成时回调
 */
- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color completion:(void (^)(UIImage *image, NSString *imageUrl))completion;

/**
 加载圆形图片

 @param url 图片的url
 @param imageSize 图片尺寸
 @param width 描边的宽度
 @param color 描边的颜色
 @param completion 加载完成的回调
 */
-(void)loadCircleImageUrl:(NSString *)url imageSize:(LinImageSize)imageSize borderWidth:(CGFloat)width borderColor:(UIColor *)color completion:(void (^)(UIImage *image, NSString *imageUrl))completion;

/**
 在UIImageView换新图片的时候，做相应的动画效果

 @param duration 动画时长
 */
- (void)setTransitionAnimationWithDuration:(CFTimeInterval)duration;

/**
 在UIImageView换新图片的时候，做相应的动画效果

 @param duration 动画时长
 @param tf 设置动画快慢 由快到慢 由慢到快
 @param type 设置动画类型 推出、淡入淡出、线性...
 @param subtype 设置动画方向
 */
- (void)setTransitionAnimationWithDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)tf type:(NSString *)type subtype:(NSString *)subtype;



@end






