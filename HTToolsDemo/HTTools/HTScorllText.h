//
//  HTScorllText.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTTextScorllStyle) {
    HTTextScorllStyleDefault,//当文字长度大于label长度的长度才可以进行滚动
    HTTextScorllStyleAlways, //无论文字长短，一直滚动
};

@interface HTScorllText : UIView

@property (nonatomic, assign) HTTextScorllStyle style; //默认ORTextCycleStyleDefault
@property (nonatomic, assign) IBInspectable CGFloat interval; //间隔 默认 20
@property (nonatomic, assign) IBInspectable CGFloat rate;//速率 0~1 默认 0.5

@property (nonatomic, copy )  IBInspectable NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

- (void)start; //默认开启
- (void)stop;

@end

NS_ASSUME_NONNULL_END
