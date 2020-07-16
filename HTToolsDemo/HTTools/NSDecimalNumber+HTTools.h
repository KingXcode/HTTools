//
//  NSDecimalNumber+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (HTTools)


- (NSDecimalNumber * (^)(NSDecimalNumber *number))add;        //加
- (NSDecimalNumber * (^)(NSDecimalNumber *number))sub;        //减
- (NSDecimalNumber * (^)(NSDecimalNumber *number))multiply;   //乘
- (NSDecimalNumber * (^)(NSDecimalNumber *number))divid;      //除

- (NSDecimalNumber * (^)(NSUInteger number))raisingToPower;               //number次方,传参是无符号整型
- (NSDecimalNumber * (^)(short number))multiplyingByPowerOf10;      //乘以 10的number次方,传参是short

@end

NS_ASSUME_NONNULL_END
