//
//  UIApplication+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIApplication+HTTools.h"

@implementation UIApplication (HTTools)

-(UIViewController *)currentViewController {
    return [UIApplication getCurrentViewController];
}

+ (UIViewController *)getCurrentViewController{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentViewControllerFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentViewControllerFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentViewControllerFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentViewControllerFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


/*!
 *  跳转系统通知
 */
+ (void)openSystermSettings
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) { }];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

/*!
*  打电话
*/
+ (void)callPhone:(NSString *)phone
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
}


/**
 系统版本
 */
+(NSString *)OSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}


@end
