//
//  HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "HTTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <objc/runtime.h>

@implementation HTTools

@end


#pragma - mark - MD5
@implementation HTTools (MD5)

/*
MD5 加密
*/
+(NSString *) md5: (NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end


#pragma - mark - BaseAll64
//空字符串
#define     LocalStr_None           @""
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation HTTools (BaseAll64)

/******************************************************************************
函数名称 : + (NSString *)base64StringFromText:(NSString *)text
函数描述 : 将文本转换为base64格式字符串
输入参数 : (NSString *)text    文本
输出参数 : N/A
返回参数 : (NSString *)    base64格式字符串
备注信息 :
******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}


/******************************************************************************
函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
函数描述 : 将base64格式字符串转换为文本
输入参数 : (NSString *)base64  base64格式字符串
输出参数 : N/A
返回参数 : (NSString *)    文本
备注信息 :
******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        NSData *data = [self dataWithBase64EncodedString:base64];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}


/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end



#pragma - mark - AOP
@implementation HTTools (AOP)

/*!
 *  替换两个方法
 *
 *  @param originalSelector 原始方法
 *  @param swizzledSelector 替换的方法
 */
+ (void)aop_swizzlingClass:(NSString *)className
          originalSelector:(SEL)originalSelector
          swizzledSelector:(SEL)swizzledSelector
{
    Class class = NSClassFromString(className);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end




#pragma - mark - RunTime

@implementation HTTools (RunTime)

/**
 通过类对象  获取到该类的所有属性  包括私有属性
 
 @param cla 类对象
 @return 包含所有私有属性名的数组
 */
+(NSArray *)logPropertyByClass:(Class) cla
{
    unsigned int count = 0;
    NSMutableArray *array = [NSMutableArray array];
    Ivar *Ivars = class_copyIvarList(cla, &count);
    
    for (int i = 0; i<count; i++) {
        
        Ivar ivar = Ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameS = [NSString stringWithUTF8String:name];
        [array addObject:nameS];
        
    }
    free(Ivars);
    return array.copy;
}

/**
 通过类对象  查看是否包含某个属性
 
 @param myClass 类对象
 @param name    类属性名
 @return  YES 包含该属性
 */
+(BOOL)getVariableWithClass:(Class) myClass varName:(NSString *)name
{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

@end


#pragma - mark - String

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
@implementation HTTools (String)


/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)numberToChinese:(NSInteger)arabicNum
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-cn"];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:arabicNum]];
}


/**
 返回字符串第一个字符
 */
+(NSString * _Nullable)getFirstCharacter:(NSString *)character
{
    if ([HTTools isNull:character]) {
        return nil;
    }
    if (character.length<1) {
        return @"";
    }
    NSString *first = [character substringToIndex:1];
    
    return first;
}

/**
 返回字符串最后一个字符
 */
+(NSString *_Nullable)getLastCharacter:(NSString *)character
{
    if ([HTTools isNull:character]) {
        return nil;
    }
    if (character.length<1) {
        return @"";
    }
    NSString *last = [character substringFromIndex:character.length-1];
    return last;
}

/**
 根据索引返回第index位的字符
 index必须小于字符串的长度  否则返回的是最后一个字符
 
 @param index 需要获取到的字符索引  从0开始
 @param string 字符串
 */
+(NSString *_Nullable)getCharacterByIndex:(NSUInteger)index forString:(NSString *)string
{
    if ([HTTools isNull:string]) {
        return nil;
    }
    if (string.length<1) {
        return @"";
    }
    if (string.length < index) {
        return [self getLastCharacter:string];
    }
    NSString *first = [string substringFromIndex:index];
    first = [self getFirstCharacter:first];
    return first;
}

/**
 字符串判空 空字符串不算
 */
+ (BOOL)isNull:(NSString * _Nullable)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 将十进制转化为二进制,设置返回NSString 长度
 
 @param tmpid 十进制数
 @param length 转换的二进制长度 可以=0
 @return 转换成二进制字符串
 */
+ (NSString *)toBinaryWithNumber:(uint16_t)tmpid backLength:(int)length
{
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }
        a = [b stringByAppendingString:a];
    }
    return a;
}

/**
 将十进制转化为十六进制
 */
+ (NSString *)toHexWithNumber:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}




/**
 将16进制转化为二进制
 
 @param hex 十六进制数
 @return 转换完成的二进制字符串
 */
+ (NSString *)getBinaryByhex:(NSString *)hex
{
    NSDictionary  *hexDic = [self getHexDic];
    NSMutableString *binaryString = [[NSMutableString alloc] init];
    for (int i = 0; i < [hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        [binaryString appendString:[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
    }
    return binaryString;
}

+(NSDictionary *)getHexDic
{
    NSMutableDictionary *hexDic = [NSMutableDictionary dictionary];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    [hexDic setObject:@"1010" forKey:@"a"];
    [hexDic setObject:@"1011" forKey:@"b"];
    [hexDic setObject:@"1100" forKey:@"c"];
    [hexDic setObject:@"1101" forKey:@"d"];
    [hexDic setObject:@"1110" forKey:@"e"];
    [hexDic setObject:@"1111" forKey:@"f"];
    
    return hexDic.copy;
}


@end




#pragma - mark - Date
@implementation HTTools (Date)


/**
 @param dateFormat the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)dateWithTime:(NSInteger)time dateFormat:(NSString * _Nullable)dateFormat
{
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    return [self dateWithDate:d dateFormat:dateFormat];
}

+(NSString *)dateWithDate:(NSDate *)date dateFormat:(NSString *_Nullable)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([self isNull:dateFormat]) {
        dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    }else{
        dateFormatter.dateFormat = dateFormat;
    }
    return [dateFormatter stringFromDate:date];
}


/*
 判断时间与当前时间的大小
 1: 未来
 -1:过去
 0: 当前
 */
+(int)dateCompareDateTime:(NSString *)otherDateString
{
    long long time = [otherDateString longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
    NSDate *today = [NSDate date];
    NSComparisonResult result = [d compare:today];
    
    if (result == NSOrderedDescending) {
        return 1;
    }else if (result == NSOrderedAscending){
        return -1;
    }else {
        return 0;
    }
}

@end

#pragma - mark - HTChecking
@implementation HTTools (HTChecking)

/** 验证字符串 format是正则表达式*/
+(BOOL)isVerifyString:(NSString *)string predicateWithFormat:(NSString *)format
{
    if ([self isNull:string]) return NO;
    NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",format];
    if ([check evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

/** 验证输入的是否是URL地址*/
+ (BOOL)isUrl:(NSString *)urlStr
{
    if ([self isNull:urlStr]) return NO;
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

/** 验证输入的是否是中文*/
+ (BOOL)isChinese:(NSString *)chineseStr
{
    if ([self isNull:chineseStr]) return NO;
    NSString *pattern = @"[\u4e00-\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:chineseStr options:0 range:NSMakeRange(0, chineseStr.length)];
    return results.count > 0;
}


/** 判断字符串是否是字母或数字*/
+ (BOOL)isLetterOrNumberString:(NSString *)string
{
    if ([self isNull:string]) return NO;
    NSString *letterOrNumberRegex = @"[A-Z0-9a-z]+";
    NSPredicate *letterOrNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterOrNumberRegex];
    return [letterOrNumberTest evaluateWithObject:string];
}

/** 判断字符串是否是数字*/
+ (BOOL)isNumber:(NSString *)string
{
    if ([self isNull:string]) return NO;
    NSString *letterOrNumberRegex = @"[0-9]*";
    NSPredicate *letterOrNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterOrNumberRegex];
    return [letterOrNumberTest evaluateWithObject:string];
}



@end
