//
//  MBProgressHUD+Loading.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/26.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Loading)


/**
 在keyWindow上面展示文本信息

 @param text 需要显示的文本信息
 @param delay 延时几秒消失
 @return 返回HUD
 */
+ (instancetype)showText:(NSString *)text afterDelay:(NSTimeInterval)delay;

/**
 显示文本信息

 @param text 需要显示的文本信息
 @param view 添加到需要显示的视图上面
 @param delay 延时几秒消失
 @return 返回HUD
 */
+ (instancetype)showText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay;


@end



