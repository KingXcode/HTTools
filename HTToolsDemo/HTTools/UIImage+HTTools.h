//
//  UIImage+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HTTools)

+ (UIImage *)imageWithColor:(UIColor *)color;

/** 截图 */
+(UIImage *)ht_screenshots;
+(UIImage *)ht_screenshotsFromView:(UIView*)v;



@end

NS_ASSUME_NONNULL_END
