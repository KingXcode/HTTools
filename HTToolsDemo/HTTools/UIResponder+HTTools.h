//
//  UIResponder+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (HTTools)

/** 当前第一响应者 */
+ (id)ht_currentFirstResponder;

@end

NS_ASSUME_NONNULL_END
