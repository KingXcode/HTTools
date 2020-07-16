//
//  UIButton+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIButton+HTTools.h"
#import <objc/runtime.h>

@implementation UIButton (HTTools)

static NSString * HT_Button_Catogary_Key = @"HT_Button_Catogary_Key";

- (instancetype) initWithHandleBlock:(targetBlock)block{
    
    self = [super init];
    if (self) {
        [self handelWithBlock:block];
    }
    return self;
}

- (void)handelWithBlock:(targetBlock)block
{
    if (block) {
        objc_setAssociatedObject(self, &HT_Button_Catogary_Key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [self addTarget:self action:@selector(targetAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) targetAction:(UIButton *)sender
{
    targetBlock block = objc_getAssociatedObject(self, &HT_Button_Catogary_Key);
    block(sender);
}

@end
