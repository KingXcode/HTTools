//
//  NSNumber+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/8/9.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "NSNumber+HTTools.h"
#import "HTTools.h"

@implementation NSNumber (HTTools)

#define HTTextHandler(text,defaultText)     (HTIsText(text) ? text : defaultText) //处理字符串，如果是非空，则返回原值，如果是空的话，返回默认值
#define HTIsText(text)                      [text isKindOfClass:[NSString class]]&&(![HTTools isNull:text])//判断是否是有长度的字符串

- (NSNumber *(^)(NSNumber *))add
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        
        NSString *f = HTTextHandler(__self.stringValue, @"0");
        NSString *s = HTTextHandler(number.stringValue, @"0");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberByAdding:second];
        return result;
    };
}

- (NSNumber *(^)(NSNumber *))sub
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        NSString *f = HTTextHandler(__self.stringValue, @"0");
        NSString *s = HTTextHandler(number.stringValue, @"0");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberBySubtracting:second];
        return result;
    };
}



- (NSNumber *(^)(NSNumber *))multiply
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        NSString *f = HTTextHandler(__self.stringValue, @"1");
        NSString *s = HTTextHandler(number.stringValue, @"1");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberByMultiplyingBy:second];
        return result;
    };
}

- (NSNumber *(^)(NSNumber *))divid
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        NSString *f = HTTextHandler(__self.stringValue, @"1");
        NSString *s = HTTextHandler(number.stringValue, @"1");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberByDividingBy:second];
        return result;
    };
}
- (NSNumber *(^)(NSNumber *))raisingToPower
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        NSString *f = HTTextHandler(__self.stringValue, @"1");
        NSString *s = HTTextHandler(number.stringValue, @"1");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberByRaisingToPower:second.unsignedIntegerValue];
        return result;
    };
}

- (NSNumber *(^)(NSNumber *))multiplyingByPowerOf10
{
    __weak typeof(self) __self = self;
    
    return ^(NSNumber *number) {
        NSString *f = HTTextHandler(__self.stringValue, @"1");
        NSString *s = HTTextHandler(number.stringValue, @"1");
        
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:f];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:s];
        NSDecimalNumber *result = [first decimalNumberByMultiplyingByPowerOf10:second.shortValue];
        return result;
    };
}

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
        NSString *string = [formatter stringFromNumber:self];
        return string;
    };
}


-(NSString * _Nonnull (^)(NSInteger precision))formatWithDigits;
{
    return ^NSString *(NSInteger precision) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = precision;
        formatter.minimumFractionDigits = precision;
        NSString *string = [formatter stringFromNumber:self];
        return string;
    };
}



@end
