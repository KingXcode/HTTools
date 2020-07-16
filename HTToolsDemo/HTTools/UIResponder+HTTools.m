//
//  UIResponder+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIResponder+HTTools.h"

static __weak id ht_currentFirstResponder;

@implementation UIResponder (HTTools)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)ht_currentFirstResponder {
    ht_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(ht_findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    return ht_currentFirstResponder;
}

- (void)ht_findCurrentFirstResponder:(id)sender {
    ht_currentFirstResponder = self;
}

@end
