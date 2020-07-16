//
//  UIViewController+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HTTools)

- (void)toLastViewController;
- (void)toLastViewControllerAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
