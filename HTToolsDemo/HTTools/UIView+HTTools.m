//
//  UIView+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIView+HTTools.h"

HTTransitionTypeName const kFadeType           = @"fade";
HTTransitionTypeName const kMoveInType         = @"moveIn";
HTTransitionTypeName const kPushType           = @"push";
HTTransitionTypeName const kRevealType         = @"reveal";
HTTransitionTypeName const kCubeType           = @"cube";
HTTransitionTypeName const kOglFlipType        = @"oglFlip";
HTTransitionTypeName const kSuckEffectType     = @"suckEffect";
HTTransitionTypeName const kRippleEffectType   = @"rippleEffect";
HTTransitionTypeName const kPageCurlType       = @"pageCurl";
HTTransitionTypeName const kPageUnCurlType     = @"pageUnCurl";


HTTransitionDirection const kFromLeftDirection      = @"fromLeft";
HTTransitionDirection const kFromRightDirection     = @"fromRight";
HTTransitionDirection const kFromTopDirection       = @"fromTop";
HTTransitionDirection const kFromBottomDirection    = @"fromBottom";

@implementation UIView (HTTools)

+(instancetype)ht_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}




+ (CATransition *)createTransitionAnimationWithType:(HTTransitionTypeName)type direction:(HTTransitionDirection)direction time:(double)time
{
    //切换之前添加动画效果
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    //设置动画的类型:
    animation.type = type;
    //设置动画的方向
    animation.subtype = direction;
    //设置动画的持续时间
    animation.duration = time;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}

- (void)addTransitionAnimationWithType:(HTTransitionTypeName)type direction:(HTTransitionDirection)direction time:(double)time
{
    CATransition *transition = [UIView createTransitionAnimationWithType:type direction:direction time:time];
    [self.layer addAnimation:transition forKey:@"animation"];
}







-(CGFloat)ht_topSafeMargin
{
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.top;
    } else {
        return 0;//iOS 11 之前的设备
    }
}

-(CGFloat)ht_bottomSafeMargin
{
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.bottom;
    } else {
        return 0;//iOS 11 之前的设备
    }
}

-(CGFloat)ht_leftSafeMargin
{
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.left;
    } else {
        return 0;//iOS 11 之前的设备
    }
}

-(CGFloat)ht_rightSafeMargin
{
    if (@available(iOS 11.0, *)) {
        return self.safeAreaInsets.right;
    } else {
        return 0;//iOS 11 之前的设备
    }
}




-(void)ht_cornerRadiusOnTop:(CGSize)size
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadiusOnBottom:(CGSize)size
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadiusOnLeft:(CGSize)size
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadiusOnRight:(CGSize)size
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath * maskPath ;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)ht_cornerRadiusWithSize:(CGSize)size byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath * maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)ht_removeAllCornerRadius
{
    self.layer.mask = nil;
}


@end
