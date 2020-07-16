//
//  NSString+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTTools)

- (NSString * (^)(NSString *number))add;        //加
- (NSString * (^)(NSString *number))sub;        //减
- (NSString * (^)(NSString *number))multiply;   //乘
- (NSString * (^)(NSString *number))divid;      //除

- (NSString * (^)(NSUInteger number))raisingToPower;    //number次方,传参是无符号整型
- (NSString * (^)(short number))multiplyingByPowerOf10; //乘以 10的number次方,传参是short

@end

NS_ASSUME_NONNULL_END
