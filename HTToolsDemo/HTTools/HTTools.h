//
//  HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTScorllText.h"
#import "UIApplication+HTTools.h"
#import "UIButton+HTTools.h"
#import "UIColor+HTTools.h"
#import "UIImage+HTTools.h"
#import "UIResponder+HTTools.h"
#import "UITableView+HTTools.h"
#import "UIView+HTTools.h"
#import "UIViewController+HTTools.h"
#import "NSDecimalNumber+HTTools.h"
#import "NSString+HTTools.h"
#import "NSDate+HTTools.h"
#import "NSArray+HTTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTools : NSObject

@end


#pragma - mark - MD5
@interface HTTools (MD5)
/*
 MD5 加密
 */
+(NSString *)md5:(NSString *) inPutText;
@end



#pragma - mark - BaseAll64
@interface HTTools (BaseAll64)

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;

@end


#pragma - mark - AOP
@interface HTTools (AOP)

/*!
 *  替换两个方法
 *
 *   className
 *   originalSelector 原始方法
 *   swizzledSelector 替换的方法
 */
+ (void)aop_swizzlingClass:(NSString *)className
          originalSelector:(SEL)originalSelector
          swizzledSelector:(SEL)swizzledSelector;

@end



#pragma - mark - RunTime
@interface HTTools (RunTime)

/**
 通过类对象  获取到该类的所有属性  包括私有属性
 
 @param cla 类对象
 @return 包含所有私有属性名的数组
 */
+(NSArray *) logPropertyByClass:(Class) cla;


/**
 通过类对象  查看是否包含某个属性
 
 @param myClass 类对象
 @param name    类属性名
 @return  YES 包含该属性
 */
+(BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name;

@end



#pragma - mark - String
@interface HTTools (String)

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)numberToChinese:(NSInteger)arabicNum;

/**
 返回字符串第一个字符
 */
+(NSString * _Nullable)getFirstCharacter:(NSString *)character;
/**
 返回字符串最后一个字符
 */
+(NSString *_Nullable)getLastCharacter:(NSString *)character;

/**
 根据索引返回第index位的字符
 index必须小于字符串的长度  否则返回的是最后一个字符
 
 @param index 需要获取到的字符索引  从0开始
 @param string 字符串
 */
+(NSString *_Nullable)getCharacterByIndex:(NSUInteger)index forString:(NSString *)string;

/**
 字符串判空 空字符串不算
 */
+ (BOOL)isNull:(NSString * _Nullable)string;

/**
 将十进制转化为二进制,设置返回NSString 长度
 
 @param tmpid 十进制数
 @param length 转换的二进制长度 可以=0
 @return 转换成二进制字符串
 */
+ (NSString *)toBinaryWithNumber:(uint16_t)tmpid backLength:(int)length;

/**
 将十进制转化为十六进制
 */
+ (NSString *)toHexWithNumber:(uint16_t)tmpid;

/**
 将16进制转化为二进制
 
 @param hex 十六进制数
 @return 转换完成的二进制字符串
 */
+ (NSString *)getBinaryByhex:(NSString *)hex;

@end



#pragma - mark - Date
@interface HTTools (Date)

/**
 @param dateFormat the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)dateWithTime:(NSInteger)time dateFormat:(NSString *_Nullable)dateFormat;
+(NSString *)dateWithDate:(NSDate *)date dateFormat:(NSString *_Nullable)dateFormat;

@end


#pragma - mark - Date
@interface HTTools (HTChecking)

/** 验证字符串 format是正则表达式*/
+(BOOL)isVerifyString:(NSString *)string predicateWithFormat:(NSString *)format;


/** 验证输入的是否是URL地址*/
+ (BOOL)isUrl:(NSString *)urlStr;

/** 验证输入的是否是中文*/
+ (BOOL)isChinese:(NSString *)chineseStr;

/** 判断字符串是否是字母或数字*/
+ (BOOL)isLetterOrNumberString:(NSString *)string;

/** 判断字符串是否是数字*/
+ (BOOL)isNumber:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
