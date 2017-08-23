//
//  UIImageView+Extension.m
//  LinFoundation
//
//  Created by LiliEhuu on 17/2/4.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "ServerManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <HYBImageCliped/UIImage+HYBmageCliped.h>


#define LinDefaultPlaceholderImage @""


@implementation NSString (INCreator)

- (NSString *)full
{
    return [self createImageName:LinImageSize_full];
}

- (NSString *)large
{
    return [self createImageName:LinImageSize_large];
}

- (NSString *)thumbnail
{
    return [self createImageName:LinImageSize_thumbnail];
}

- (NSString *)createImageName:(LinImageSize)imageSize
{
    //按图片的大小拼接链接
    NSString *absUrl = nil;
    //分割图片名称：名称 + 后缀
    NSArray *imageComponents = [self componentsSeparatedByString:@"."];
    switch (imageSize)
    {
        case LinImageSize_full:
            absUrl = [NSString stringWithFormat:@"%@_full.%@", imageComponents.firstObject, imageComponents.lastObject];
            break;
        case LinImageSize_large:
            absUrl = [NSString stringWithFormat:@"%@_large.%@", imageComponents.firstObject, imageComponents.lastObject];
            break;
        case LinImageSize_thumbnail:
            absUrl = [NSString stringWithFormat:@"%@_thumbnail.%@", imageComponents.firstObject, imageComponents.lastObject];
            break;
            
        default:
            absUrl = [NSString stringWithFormat:@"%@_thumbnail.%@", imageComponents.firstObject, imageComponents.lastObject];
            break;
    }
    
    return absUrl;
}

@end


@implementation UIImageView (Extension)


- (void)setCircleImage:(UIImage *)image
{
    self.image = [image hyb_clipCircleToSize:self.bounds.size];
}

- (void)setCircleImage:(UIImage *)image borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    image.hyb_borderColor = color;
    image.hyb_borderWidth = width;
    self.image = [image hyb_clipCircleToSize:self.bounds.size];
}


#pragma mark - 缓存、加载

- (NSURL *)URLWithString:(NSString *)url size:(LinImageSize)imageSize
{
    //按图片的大小拼接链接
    NSString *absUrl = [url nonull];
    switch (imageSize)
    {
        case LinImageSize_full:
            absUrl = [url full];
            break;
        case LinImageSize_large:
            absUrl = [url large];
            break;
        case LinImageSize_thumbnail:
            absUrl = [url thumbnail];
            break;
            
        default:
            absUrl = [url thumbnail];
            break;
    }
    
    return [NSURL URLWithString:strapd(SERVER_ASSETS_ROOT, absUrl)];
}

- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize placeholderImage:(UIImage *)pImage completion:(void (^)(UIImage *, NSString *))completion
{
    //SDWebImage 缓存
    [self sd_setImageWithURL:[self URLWithString:url size:imageSize] placeholderImage:pImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //传出图片
        if (completion)
        {
            completion(image, imageURL.absoluteString);
        }
        
        if (!error && error.userInfo.count)
        {
            GALog(@"图片连接错误: %@ 图片链接: %@", error.userInfo[NSLocalizedDescriptionKey], imageURL.absoluteString);
        }
    }];
}


- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize completion:(void (^)(UIImage *, NSString *))completion
{
    UIImage *pImage = [UIImage imageNamed:LinDefaultPlaceholderImage];
    [self loadImage:url imageSize:imageSize placeholderImage:pImage completion:completion];
}


- (void)loadImage:(NSString *)url imageSize:(LinImageSize)imageSize cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color completion:(void (^)(UIImage *image, NSString *imageUrl))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //在子线程中对占位图圆角
        UIImage *placeholderImage = [UIImage imageNamed:LinDefaultPlaceholderImage];
        placeholderImage.hyb_borderWidth = width;
        placeholderImage.hyb_borderColor = color;
        UIImage *placeCircleImage = [placeholderImage hyb_clipToSize:self.bounds.size cornerRadius:cornerRadius backgroundColor:[UIColor whiteColor] isEqualScale:YES];
        __weak __typeof(self) weakSelf = self;
        //下载图片
        [self sd_setImageWithURL:[self URLWithString:url size:imageSize] placeholderImage:placeCircleImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (error)
            {
                return;
            }
            //当前的block处于主线程队列中，所以图片本身圆角这种耗时操作需要在子线程中进行
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //对下载好的图片圆角
                image.hyb_borderColor = color;
                image.hyb_borderWidth = width;
                UIImage *clipImage = [image hyb_clipToSize:weakSelf.bounds.size cornerRadius:cornerRadius backgroundColor:[UIColor whiteColor] isEqualScale:YES];
                //在主线程中设置图片
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.image = clipImage;
                });
                
                if (completion)
                {
                    completion(clipImage, url);
                }
            });
        }];
    });
}

- (void)loadCircleImageUrl:(NSString *)url imageSize:(LinImageSize)imageSize borderWidth:(CGFloat)width borderColor:(UIColor *)color completion:(void (^)(UIImage *, NSString *))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //在子线程中对占位图圆角
        UIImage *placeholderImage = [UIImage imageNamed:LinDefaultPlaceholderImage];
        placeholderImage.hyb_borderWidth = width;
        placeholderImage.hyb_borderColor = color;
        UIImage *placeCircleImage = [placeholderImage hyb_clipCircleToSize:self.bounds.size];
        __weak __typeof(self) weakSelf = self;
        //下载图片
        [self sd_setImageWithURL:[self URLWithString:url size:imageSize] placeholderImage:placeCircleImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (error)
            {
                return;
            }
            //当前的block处于主线程队列中，所以图片本身圆角这种耗时操作需要在子线程中进行
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //对下载好的图片圆角
                image.hyb_borderColor = color;
                image.hyb_borderWidth = width;
                UIImage *clipImage = [image hyb_clipCircleToSize:self.bounds.size];
                //在主线程中设置图片
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.image = clipImage;
                });
                
                if (completion)
                {
                    completion(clipImage, url);
                }
            });
        }];
    });
}


#pragma mark - 动画

- (void)setTransitionAnimationWithDuration:(CFTimeInterval)duration
{
    //动画时机效果 线性
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画
    [self setTransitionAnimationWithDuration:duration timingFunction:tf type:kCATransitionFade subtype:kCATransitionFromLeft];
}

- (void)setTransitionAnimationWithDuration:(CFTimeInterval)duration timingFunction:(CAMediaTimingFunction *)tf type:(NSString *)type subtype:(NSString *)subtype
{
    //创建一个CATransition对象
    CATransition *transition = [CATransition animation];
    //设置时长
    transition.duration = duration;
    //设置动画快慢 由快到慢 由慢到快 ...
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.timingFunction = tf;
    //动画类型 推送 淡入淡出 ...
    transition.type = type;     //{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    //更多私有{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    //动画方向
    transition.subtype = subtype;   //{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
    //添加动画到当前视图图层
    [self.layer addAnimation:transition forKey:nil];
}


@end





