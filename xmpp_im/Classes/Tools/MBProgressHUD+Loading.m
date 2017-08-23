//
//  MBProgressHUD+Loading.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/26.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "MBProgressHUD+Loading.h"


@implementation MBProgressHUD (Loading)


+ (instancetype)showText:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    return [self showText:text toView:[UIApplication sharedApplication].keyWindow afterDelay:delay];
}

+ (instancetype)showText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    CGPoint offset = hud.offset;
    offset.y = ([UIScreen mainScreen].bounds.size.height/2.0f)*(0.53973013);
    hud.offset = offset;
    [hud hideAnimated:YES afterDelay:delay];

    return hud;
}


@end




