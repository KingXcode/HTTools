//
//  UIImage+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIImage+HTTools.h"

@interface UIColorCache : NSObject

@property (nonatomic,strong)    NSCache *colorImageCache;

@end

@implementation UIColorCache
+ (instancetype)sharedCache
{
    static UIColorCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UIColorCache alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _colorImageCache = [[NSCache alloc] init];
    }
    return self;
}

- (UIImage *)image:(UIColor *)color
{
    return color ? [_colorImageCache objectForKey:[color description]] : nil;
}

- (void)setImage:(UIImage *)image
        forColor:(UIColor *)color
{
    [_colorImageCache setObject:image
                         forKey:[color description]];
}
@end




@implementation UIImage (HTTools)

+ (UIImage *)imageWithColor:(UIColor *)color {
    if (color == nil) {
        assert(0);
        //DDLogError(@"Invalid Param");
        return nil;
    }
    UIImage *image = [[UIColorCache sharedCache] image:color];
    if (image == nil)
    {
        CGFloat alphaChannel;
        [color getRed:NULL green:NULL blue:NULL alpha:&alphaChannel];
        BOOL opaqueImage = (alphaChannel == 1.0);
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, opaqueImage, [UIScreen mainScreen].scale);
        [color setFill];
        UIRectFill(rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [[UIColorCache sharedCache] setImage:image
                                    forColor:color];
    }
    return image;
}




+ (UIImage *) ht_screenshots {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [self ht_screenshotsFromView:keyWindow];
}


+(UIImage*)ht_screenshotsFromView:(UIView*)v {
    CGSize s = v.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}







@end
