//
//  UIViewController+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UIViewController+HTTools.h"

@implementation UIViewController (HTTools)

- (void)toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)toLastViewControllerAnimation:(BOOL)animation
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:animation completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:animation];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:animation completion:nil];
    }
}

@end
