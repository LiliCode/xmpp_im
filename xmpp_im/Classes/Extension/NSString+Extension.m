//
//  NSString+Extension.m
//  LinFoundation
//
//  Created by LiliEhuu on 17/1/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>   //MD5


@implementation NSString (Extension)

+ (NSString *)md5:(NSString *)sourceString
{
    const char *cString = [sourceString UTF8String];
    //存放加密后的字符串
    unsigned char digest[CC_MD5_DIGEST_LENGTH] = {};
    //md5
    CC_MD5(cString, (uint32_t)strlen(cString), digest);
    //重组，转换成OC字符串
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int count = 0; count < CC_MD5_DIGEST_LENGTH; count ++)
    {
        [md5String appendFormat:@"%02x", digest[count]];    //拼接成OC字符串
    }
    
    return [[md5String uppercaseString] copy];
}


+ (NSString *)doubleMd5:(NSString *)sourceString
{
    return [[NSString md5:[NSString md5:sourceString]] uppercaseString];
}

- (instancetype)stringValue
{
    return self;
}

- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *futureString = [NSMutableString stringWithString:self];
    if (range.length == 0)
    {
        [futureString insertString:string atIndex:range.location];
    }
    else
    {
        [futureString deleteCharactersInRange:range];
    }
    
    return futureString;
}

//身份证验证
- (BOOL)checkoutIdNumber:(NSUInteger)length
{
    BOOL result = NO;
    //18位
    if(18 == length)
    {
        result = [self checkout];
    }
    else if(15 == length)
    {
        result = [self checkoutNum];
    }
    
    return result;
}

/**
 *  检验18位
 */
- (BOOL)checkout
{
    //转码 UTF-8
    char *string = (char *)[self UTF8String];
    //身份证号码
    char number[19] = {0};   //字符串以'\0'结束，所有19位
    //17个对应数字
    int base[17] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //最后的一个编号
    
    int lastNumbers[11] = {1,0,'X',9,8,7,6,5,4,3,2};
    //num循环变量，sum相乘求和结果，lastNum最后一位数字下标编号
    int count = 0,sum = 0, lastNum = 0;
    
    //先检验长度
    if(18 != strlen(string))
    {
        return NO;
    }
    else
    {
        //位数正确就复制
        strcpy(number, string);
    }
    
    //每输入一个数字就相乘求和
    for(count = 0;count <= 16; count++)
    {
        sum += (number[count] - '0') * base[count];
    }
    //求和结果对11求余
    lastNum = sum % 11;
    if(lastNumbers[lastNum] == 'X')
    {
        if(lastNumbers[lastNum] == number[17] || lastNumbers[lastNum] == number[17] - 32)   //判断小写'x'
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if(lastNumbers[lastNum] + '0' == number[17])
            return YES;
        else
            return NO;
    }
}

/**
 *  检验15位身份证 必须全是数字
 */
- (BOOL)checkoutNum
{
    char *string = (char *)[self UTF8String];
    
    for(; *string != '\0'; string++)
    {
        if(*string < '0' || *string > '9')    //如果出现的字符在 '0'~'9'之外 返回false
        {
            return NO;
        }
    }
    
    return YES;
}

- (NSString *)getStarPhoneNumber
{
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(3, 4)] withString:@"****"];

}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isSpaceString
{
    if (!self.length)
    {
        return NO;  //如果为空串 长度为0
    }
    
    for (NSInteger i = 0; i < self.length; i++)
    {
        NSRange r = NSMakeRange(i, 1);
        NSString *bit = [self substringWithRange:r];
        if (![bit isEqualToString:@" "])
        {
            return NO;
        }
    }
    
    return YES;
}

- (NSString *)filterString:(NSString *)aString
{
    if (!self.length)
    {
        return self;
    }
    
    NSMutableString *mString = [self mutableCopy];
    NSRange r = [mString rangeOfString:aString];
    while (r.location != NSNotFound)
    {
        [mString deleteCharactersInRange:r];
        r = [mString rangeOfString:aString];
    }
    
    return [mString copy];
}

- (NSString *)filterSpace
{
    return [self filterString:@" "];
}

- (NSMutableAttributedString *)findEqualStringWithString:(NSString *)str color:(UIColor *)color
{
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSRange range;
    range = [self rangeOfString:str];
    
    if (range.location != NSNotFound)
    {
        [newStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    else
    {
        NSLog_debug(@"Not Found");
    }
    
    return newStr;
}


- (BOOL)checkPhoneNumInput
{
    NSString*pattern =@"^1+[34578]+\\d{9}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

- (BOOL)isBankCard{
    if(self.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++){
        c = [self characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9)
            {
                addend -= 9;
            }
        }
        else
        {
            addend = digit;
        }
        
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

//判断是否为整形：
- (BOOL)isPureInteger
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


//判断是否为浮点形：
- (BOOL)isPureFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


/**
 *  是否是数字字符串
 */
- (BOOL)isNumberString
{
    return [self isPureFloat] || [self isPureInteger];
}

+(NSArray *)stringToArrayWithString:(NSString *)string
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i< string.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *s = [string substringWithRange:range];
        [arr addObject:s];
    }
    return [arr copy];
}

-(NSInteger)stringContainString:(NSString *)string
{
    NSArray *stringArr = [NSString stringToArrayWithString:self];
    
    NSMutableArray *containString = [NSMutableArray array];
    
    for (int i=0; i < stringArr.count; i++)
    {
        NSString *str = stringArr[i];
        if ([str isEqualToString:string])
        {
            [containString addObject:str];
        }
    }
    return containString.count;
}

@end



