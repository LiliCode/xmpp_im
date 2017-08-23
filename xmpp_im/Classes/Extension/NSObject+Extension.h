//
//  NSObject+Extension.h
//  linlin2
//
//  Created by LiliEhuu on 17/2/24.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)


/**
 取出NSNull对象

 @return 该对象的值为nil或者是NSNull对象则返回nil指针
 */
- (id)nonull;

@end
