//
//  UIColor+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HTTools)

+ (UIColor *)colorWithHexValue:(NSInteger)rgbValue;
+ (UIColor *)colorWithHexValue:(NSInteger)rgbValue alphValue:(CGFloat)alphValue;

@end

NS_ASSUME_NONNULL_END
