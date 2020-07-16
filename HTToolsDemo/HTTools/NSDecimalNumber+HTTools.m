//
//  NSDecimalNumber+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "NSDecimalNumber+HTTools.h"

@implementation NSDecimalNumber (HTTools)

- (NSDecimalNumber * (^)(NSDecimalNumber *number))add;        //加
{
    __weak typeof(self) __self = self;
    return ^(NSDecimalNumber *number) {
        NSDecimalNumber *result = [__self decimalNumberByAdding:number];
        return result;
    };
}

- (NSDecimalNumber * (^)(NSDecimalNumber *number))sub;        //减
{
    __weak typeof(self) __self = self;
    return ^(NSDecimalNumber *number) {
        NSDecimalNumber *result = [__self decimalNumberBySubtracting:number];
        return result;
    };
}
- (NSDecimalNumber * (^)(NSDecimalNumber *number))multiply;   //乘
{
    __weak typeof(self) __self = self;
    
    return ^(NSDecimalNumber *number) {
        NSDecimalNumber *result = [__self decimalNumberByMultiplyingBy:number];
        return result;
    };
}
- (NSDecimalNumber * (^)(NSDecimalNumber *number))divid;      //除
{
    __weak typeof(self) __self = self;
    return ^(NSDecimalNumber *number) {
        NSDecimalNumber *result = [__self decimalNumberByDividingBy:number];
        return result;
    };
}

- (NSDecimalNumber * (^)(NSUInteger number))raisingToPower;//number次方,传参是无符号整型
{
    __weak typeof(self) __self = self;
    return ^(NSUInteger number) {
        NSDecimalNumber *result = [__self decimalNumberByRaisingToPower:number];
        return result;
    };
}

- (NSDecimalNumber * (^)(short number))multiplyingByPowerOf10;//乘以 10的number次方,传参是short
{
    __weak typeof(self) __self = self;
    return ^(short number) {
        NSDecimalNumber *result = [__self decimalNumberByMultiplyingByPowerOf10:number];
        return result;
    };
}
@end
