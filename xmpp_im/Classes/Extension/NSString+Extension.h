//
//  NSString+Extension.h
//  LinFoundation
//
//  Created by LiliEhuu on 17/1/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


/**
 MD5加密字符串

 @param sourceString 即将需要加密的字符串
 @return 返回加密后的字符串
 */
+ (NSString *)md5:(NSString *)sourceString;


/**
 双MD5加密字符串

 @param sourceString 即将需要加密的字符串
 @return 返回加密后的字符串
 */
+ (NSString *)doubleMd5:(NSString *)sourceString;

/**
 字符串值
 ----用途：加载网络数据时，防止对NSNumber对象发送stringValue消息时崩溃

 @return 返回字符串
 */
- (instancetype)stringValue;


/**
 实时监听textField.text的改变

 @param range 输入的位置和长度
 @param string 输入的字符串
 @return 返回实时监听的textField.text
 */
- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 *  功能:18位和15位身份证号码检验，18位检测位数和最后的校验位是否正确
 *  15位只检测是否全是数字
 *  参数:length 身份证位数 18 || 15
 */
- (BOOL)checkoutIdNumber:(NSUInteger)length;



/**
 //去首尾空格和换行符 让“ 123 45 6 78 ” -> "123 45 6 78"

 @return 返回去除首尾空格后的字符串
 */
- (NSString *)trim;

/**
 是否是空格字符串 "   "

 @return 如果是空格字符串返回YES
 */
- (BOOL)isSpaceString;

/**
 过滤字符串

 @param aString 需要过滤的字符串
 @return 返回过滤之后的字符串
 */
- (NSString *)filterString:(NSString *)aString;

/**
 过滤空格字符

 @return 返回无空格字符串
 */
- (NSString *)filterSpace;

/**
 获取加密加“*”手机号
 17713582481 -> 177****2481

 */
- (NSString *)getStarPhoneNumber;

/**
 匹配字符串变色

 @param str 需要变色的字符
 @param color 改变后的颜色
 @return 变色后的字符串
 */
- (NSMutableAttributedString *)findEqualStringWithString:(NSString *)str color:(UIColor *)color;


/**
 是否为正确手机号

 @return 手机号正确yes 错误no
 */
- (BOOL)checkPhoneNumInput;


/**
 是否是银行卡号

 @return 正确yes 错误no
 */
- (BOOL)isBankCard;

/**
 *  是否是数字字符串
 */
- (BOOL)isNumberString;

//判断是否为整形：
- (BOOL)isPureInteger;

//判断是否为浮点形：
- (BOOL)isPureFloat;


/**
 把字符串转成一个数组字符
 @param string 要转的字符串
 @return 字符数组
 */
+(NSArray *)stringToArrayWithString:(NSString *)string;


/**
 字符串中包含某个字符字符的个数

 @param string 包含的某个字符
 @return 包含几个相同的字符串 ,专治小数多输小数点
 */
-(NSInteger)stringContainString:(NSString *)string;

@end

