//
//  UIButton+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^targetBlock)(UIButton *);

@interface UIButton (HTTools)

- (void)handelWithBlock:(targetBlock)block;
- (instancetype)initWithHandleBlock:(targetBlock)block;

@end

NS_ASSUME_NONNULL_END
