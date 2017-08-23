//
//  UIImage+Extension.m
//  linlin2
//
//  Created by LiliEhuu on 17/3/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Extension)

+ (UIImageFormat)typeForImageData:(NSData *)data
{
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c)
    {
        case 0xFF: return UIImageFormat_JPEG; break;
            
        case 0x89: return UIImageFormat_PNG;  break;
            
        case 0x47: return UIImageFormat_GIF;  break;
            
        case 0x49:
        case 0x4D: return UIImageFormat_TIFF; break;
    }
    
    return UIImageFormat_other;
}

+ (NSString *)typeName:(UIImageFormat)type
{
    NSArray *typeList = @[@"jpg", @"png", @"gif", @"tiff"];
    return [typeList objectAtIndex:(NSUInteger)type];
}

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor
{
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f)
        return self;
    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0)
        boxSize ++;
    //create image buffers
    CGImageRef imageRef = self.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    //free buffers
    free(buffer2.data);
    free(tempBuffer);
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height, 8, buffer1.rowBytes, CGImageGetColorSpace(imageRef), CGImageGetBitmapInfo(imageRef));
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, alpha);
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
}


@end









