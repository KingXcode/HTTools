//
//  UIApplication+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (HTTools)

@property (nonatomic,weak,readonly) UIViewController * currentViewController;
+ (UIViewController *)getCurrentViewController;


/*!
 *  跳转系统通知
 */
+ (void)openSystermSettings;


/*!
*  打电话
*/
+ (void)callPhone:(NSString *)phone;

/**
 系统版本
 */
+(NSString *)OSVersion;

@end

NS_ASSUME_NONNULL_END
