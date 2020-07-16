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
@end
