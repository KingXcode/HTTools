//
//  NSString+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "NSString+HTTools.h"
#import "NSDecimalNumber+HTTools.h"

@implementation NSString (HTTools)


- (NSString * (^)(NSString *number))add;        //加
{
    __weak typeof(self) __self = self;
    return ^(NSString *number) {
        if (![number isKindOfClass:NSString.class] || number.length <= 0) { number = @"0"; }
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = first.add(second);
        return result.stringValue;
    };
}


- (NSString * (^)(NSString *number))sub;        //减
{
    __weak typeof(self) __self = self;
    return ^(NSString *number) {
        if (![number isKindOfClass:NSString.class] || number.length <= 0) { number = @"0"; }
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = first.sub(second);
        return result.stringValue;
    };
}

- (NSString * (^)(NSString *number))multiply;   //乘
{
    __weak typeof(self) __self = self;
    return ^(NSString *number) {
        if (![number isKindOfClass:NSString.class] || number.length <= 0) { number = @"0"; }
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = first.multiply(second);
        return result.stringValue;
    };
}

- (NSString * (^)(NSString *number))divid;      //除
{
    __weak typeof(self) __self = self;
    return ^(NSString *number) {
        if (![number isKindOfClass:NSString.class] || number.length <= 0) { number = @"0"; }
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = first.divid(second);
        return result.stringValue;
    };
}

- (NSString * (^)(NSUInteger number))raisingToPower;    //number次方,传参是无符号整型
{
    __weak typeof(self) __self = self;
    return ^(NSUInteger number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *result = first.raisingToPower(number);
        return result.stringValue;
    };
}

- (NSString * (^)(short number))multiplyingByPowerOf10; //乘以 10的number次方,传参是short
{
    __weak typeof(self) __self = self;
    return ^(short number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:__self];
        NSDecimalNumber *result = first.multiplyingByPowerOf10(number);
        return result.stringValue;
    };
}


- (NSDecimalNumber *)standardToNumber {
    if ([self isEqualToString:@""]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return [NSDecimalNumber decimalNumberWithString:self];
}



/// 数字小数位数格式化与stepSize的小数位数相同
-(NSString * _Nonnull (^)(NSDecimalNumber *stepSize))format;
{
    return ^NSString *(NSDecimalNumber *stepSize) {
        NSInteger precision = ABS(stepSize.decimalValue._exponent);
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = precision;
        formatter.minimumFractionDigits = precision;
        NSString *string = [formatter stringFromNumber:[self standardToNumber]];
        return string;
    };
}


/// 指定小数位数
-(NSString * _Nonnull (^)(NSInteger precision))formatWithDigits;
{
    return ^NSString *(NSInteger precision) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = precision;
        formatter.minimumFractionDigits = precision;
        NSString *string = [formatter stringFromNumber:[self standardToNumber]];
        return string;
    };
}
\


/**
 字符串判空 空字符串不算
 */
- (BOOL)isNull
{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
