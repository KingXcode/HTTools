//
//  UITableView+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HTTableViewAnimationType){
    HTTableViewAnimationTypeLeft = 0,//从左出现
    HTTableViewAnimationTypeSpringLeft,//带弹簧效果 从左出现
    HTTableViewAnimationTypeAlpha,//淡入淡出
    HTTableViewAnimationTypeToTop,//从下往上出现
    HTTableViewAnimationTypeSpringToTop,//带弹簧效果 从下往上出现
    HTTableViewAnimationTypeToBottom,//从上往下出现
    HTTableViewAnimationTypeSpringToBottom,//带弹簧效果 从上往下出现
    HTTableViewAnimationTypeShake,//交叉式出现
    HTTableViewAnimationTypeOverTurn//翻转出现
};

typedef void(^CompletionHandler)(BOOL finish);

@interface UITableView (HTTools)

- (void)showWithAnimationType:(HTTableViewAnimationType)animationType completion:(CompletionHandler)completion;
- (void)hiddenWithAnimationType:(HTTableViewAnimationType)animationType completion:(CompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
