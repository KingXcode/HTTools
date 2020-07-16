//
//  UIView+HTTools.h
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *HTTransitionTypeName NS_EXTENSIBLE_STRING_ENUM;
typedef NSString *HTTransitionDirection NS_EXTENSIBLE_STRING_ENUM;

extern HTTransitionTypeName const kFadeType;//淡出效果
extern HTTransitionTypeName const kMoveInType;//新视图移动到旧视图
extern HTTransitionTypeName const kPushType;//新视图推出旧视图
extern HTTransitionTypeName const kRevealType;//移开旧视图
extern HTTransitionTypeName const kCubeType;//立方体翻转效果
extern HTTransitionTypeName const kOglFlipType;//翻转效果
extern HTTransitionTypeName const kSuckEffectType;//收缩效果
extern HTTransitionTypeName const kRippleEffectType;//水滴波纹效果
extern HTTransitionTypeName const kPageCurlType;//向下翻页
extern HTTransitionTypeName const kPageUnCurlType;//向上翻页

extern HTTransitionDirection const kFromLeftDirection;
extern HTTransitionDirection const kFromRightDirection;
extern HTTransitionDirection const kFromTopDirection;
extern HTTransitionDirection const kFromBottomDirection;


@interface UIView (HTTools)



+(instancetype)ht_viewFromXib;







- (void)addTransitionAnimationWithType:(HTTransitionTypeName)type
                             direction:(HTTransitionDirection)direction
                                  time:(double)time;
+ (CATransition *)createTransitionAnimationWithType:(HTTransitionTypeName)type
                                          direction:(HTTransitionDirection)direction
                                               time:(double)time;





@property (nonatomic,assign,readonly) CGFloat ht_topSafeMargin;
@property (nonatomic,assign,readonly) CGFloat ht_bottomSafeMargin;
@property (nonatomic,assign,readonly) CGFloat ht_leftSafeMargin;
@property (nonatomic,assign,readonly) CGFloat ht_rightSafeMargin;





-(void)ht_cornerRadiusOnTop:(CGSize)size;
-(void)ht_cornerRadiusOnBottom:(CGSize)size;
-(void)ht_cornerRadiusOnLeft:(CGSize)size;
-(void)ht_cornerRadiusOnRight:(CGSize)size;
-(void)ht_cornerRadius:(CGFloat)cornerRadius;
-(void)ht_cornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;
-(void)ht_cornerRadiusWithSize:(CGSize)size byRoundingCorners:(UIRectCorner)corners;
-(void)ht_removeAllCornerRadius;


@end

NS_ASSUME_NONNULL_END
