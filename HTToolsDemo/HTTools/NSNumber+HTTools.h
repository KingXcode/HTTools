//
//  NSNumber+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/8/9.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (HTTools)

- (NSNumber * (^)(NSNumber *number))add;        //加
- (NSNumber * (^)(NSNumber *number))sub;        //减
- (NSNumber * (^)(NSNumber *number))multiply;   //乘
- (NSNumber * (^)(NSNumber *number))divid;      //除
- (NSNumber * (^)(NSNumber *number))raisingToPower;              //number次方,传参是无符号整型的字符串
- (NSNumber * (^)(NSNumber *number))multiplyingByPowerOf10;      //乘以 10的number次方,传参是short字符串

//带千分位分隔符
-(NSString * _Nonnull (^)(NSDecimalNumber *stepSize))format;
-(NSString * _Nonnull (^)(NSInteger precision))formatWithDigits;


@end

NS_ASSUME_NONNULL_END
