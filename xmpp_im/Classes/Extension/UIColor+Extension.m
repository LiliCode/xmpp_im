//
//  UIColor+Extension.m
//  LinFoundation
//
//  Created by LiliEhuu on 17/2/6.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIColor+Extension.h"


UIColor *UIColorHex(const char *hexValue, CGFloat alpha)
{
    return [UIColor colorWithHexValue:[NSString stringWithUTF8String:hexValue] alpha:alpha];
}


@implementation UIColor (Extension)

+ (UIColor *)hexColor:(NSString *)hexValue alpha:(CGFloat)alpha
{
    return [self colorWithHexValue:hexValue alpha:alpha];
}

+(UIColor *)colorWithHexValue:(NSString *)hexValue alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexValue];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

+ (unsigned int)intFromHexString:(NSString *)hexStr
{
    if([hexStr isEqual:[NSNull null]])
    {
        hexStr = @"#000000";
    }
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}


+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}


@end
