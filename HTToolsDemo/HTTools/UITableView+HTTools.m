//
//  UITableView+HTTools.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/17.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "UITableView+HTTools.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define HTHEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation UITableView (HTTools)

#pragma -mark- 显示
- (void)showWithAnimationType:(HTTableViewAnimationType)animationType completion:(CompletionHandler)completion
{
    switch (animationType) {
        case HTTableViewAnimationTypeLeft:
            [self moveAnimationFromLeftCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringLeft:
            [self moveAnimationFromSpringLeftCompletion:completion];
            break;
        case HTTableViewAnimationTypeAlpha:
            [self alphaAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeToTop:
            [self toTopAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringToTop:
            [self springToTopAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeToBottom:
            [self toBottomAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringToBottom:
            [self springToBottomAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeShake:
            [self shakeAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeOverTurn:
            [self overTurnAnimationCompletion:completion];
            break;
        default:
            if (completion) { completion(NO); }
            break;
    }
}





#pragma -mark- 隐藏
- (void)hiddenWithAnimationType:(HTTableViewAnimationType)animationType completion:(CompletionHandler)completion
{
    switch (animationType) {
        case HTTableViewAnimationTypeLeft:
            [self hiddenMoveAnimationToLeftCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringLeft:
            [self hiddenMoveAnimationToSpringLeftCompletion:completion];
            break;
        case HTTableViewAnimationTypeAlpha:
            [self hiddenAlphaAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeToTop:
            [self hiddenToTopAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringToTop:
            [self hiddenSpringToTopAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeToBottom:
            [self hiddenToBottomAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeSpringToBottom:
            [self hiddenSpringToBottomAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeShake:
            [self hiddenShakeAnimationCompletion:completion];
            break;
        case HTTableViewAnimationTypeOverTurn:
            [self hiddenOverTurnAnimationCompletion:completion];
            break;
        default:
            if (completion) { completion(NO); }
            break;
    }
}


#pragma -mark- HTTableViewAnimationTypeLeft
- (void)moveAnimationFromLeftCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    NSTimeInterval durationTime = 0.25;
    NSTimeInterval delayTime = 0.3;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame), 0);
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:0 animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

- (void)hiddenMoveAnimationToLeftCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    NSTimeInterval durationTime = 0.25;
    CGFloat delayTime = 0.3;

    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame), 0);
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}


#pragma -mark- HTTableViewAnimationTypeSpringLeft
- (void)moveAnimationFromSpringLeftCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    NSTimeInterval durationTime = 0.75;
    NSTimeInterval delayTime = 0.4;
    NSTimeInterval springTime = 0.75;
    NSTimeInterval initialSpring = 1/0.75;
    
    
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame), 0);
    }
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}


- (void)hiddenMoveAnimationToSpringLeftCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    __block NSInteger count = 0;
    NSTimeInterval durationTime = 0.75;
    NSTimeInterval delayTime = 0.4;
    NSTimeInterval springTime = 0.75;
    NSTimeInterval initialSpring = 1/0.75;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformIdentity;
    }

    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame), 0);
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeAlpha
- (void)alphaAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSTimeInterval durationTime = 0.3;
    NSTimeInterval delayTime = 0.05;
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.alpha = 0.0;
        
        [UIView animateWithDuration:durationTime delay:i*delayTime options:0 animations:^{
            
            cell.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}
- (void)hiddenAlphaAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.3;

    NSTimeInterval delayTime = 0.05;
    
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.alpha = 1.0;
        
        [UIView animateWithDuration:durationTime delay:i*delayTime options:0 animations:^{
            
            cell.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeToTop
- (void)toTopAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
 
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.35;
    
    NSTimeInterval delayTime = 0.8;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformMakeTranslation(0,  CGRectGetWidth(cell.frame));
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

- (void)hiddenToTopAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.35;
    
    NSTimeInterval delayTime = 0.8;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(0,  CGRectGetWidth(cell.frame));
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeSpringToTop
- (void)springToTopAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.7f;
    NSTimeInterval delayTime = 1.0;
    NSTimeInterval springTime = 0.85;
    NSTimeInterval initialSpring = 1/0.85;

    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 0.f;
        
        cell.layer.transform = CATransform3DMakeTranslation(0, HTHEIGHT, 20);
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            cell.layer.opacity = 1.0f;
            
            cell.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

- (void)hiddenSpringToTopAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }

    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.7f;
    NSTimeInterval delayTime = 1.0;
    NSTimeInterval springTime = 0.85;
    NSTimeInterval initialSpring = 1/0.85;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 1.0f;
        
        cell.layer.transform = CATransform3DIdentity;
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            cell.layer.opacity = 0.f;
            
            cell.layer.transform = CATransform3DMakeTranslation(0, HTHEIGHT, 20);
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}


#pragma -mark- HTTableViewAnimationTypeToBottom
- (void)toBottomAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSTimeInterval durationTime = 0.3;
    
    NSTimeInterval delayTime = 0.8;
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformMakeTranslation(0, - CGRectGetWidth(cell.frame));
        
        [UIView animateWithDuration:durationTime delay:(cells.count - i)*(delayTime/cells.count) options:0 animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}
- (void)hiddenToBottomAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSTimeInterval durationTime = 0.3;

    NSTimeInterval delayTime = 0.8;
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformIdentity;

        [UIView animateWithDuration:durationTime delay:(cells.count - i)*(delayTime/cells.count) options:0 animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(0, - CGRectGetWidth(cell.frame));
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeSpringToBottom
- (void)springToBottomAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.3f;
    NSTimeInterval delayTime = 1.0;
    NSTimeInterval springTime = 0.85;
    NSTimeInterval initialSpring = 1/0.85;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 0.f;
        
        cell.layer.transform = CATransform3DMakeTranslation(0, -HTHEIGHT, 20);
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            cell.layer.opacity = 1.0f;
            
            cell.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

- (void)hiddenSpringToBottomAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.3f;
    NSTimeInterval delayTime = 1.0;
    NSTimeInterval springTime = 0.85;
    NSTimeInterval initialSpring = 1/0.85;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 1.0f;
        
        cell.layer.transform = CATransform3DIdentity;
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            cell.layer.opacity = 0.f;
            
            cell.layer.transform = CATransform3DMakeTranslation(0, -HTHEIGHT, 20);
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeShake
- (void)shakeAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSTimeInterval durationTime = 0.4;
    NSTimeInterval delayTime = 0.03;
    NSTimeInterval springTime = 0.75;
    NSTimeInterval initialSpring = 1/0.75;
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        if (i%2 == 0) {
            cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame),0);
        }else {
            cell.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(cell.frame),0);
        }
        [UIView animateWithDuration:durationTime delay:i*delayTime usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:0 animations:^{
            
            cell.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}
- (void)hiddenShakeAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }

    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.4;
    NSTimeInterval delayTime = 0.03;
    NSTimeInterval springTime = 0.75;
    NSTimeInterval initialSpring = 1/0.75;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.transform = CGAffineTransformIdentity;

        [UIView animateWithDuration:durationTime delay:i*delayTime usingSpringWithDamping:springTime initialSpringVelocity:initialSpring options:0 animations:^{
            
            if (i%2 == 0) {
                cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(cell.frame),0);
            }else {
                cell.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(cell.frame),0);
            }
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

#pragma -mark- HTTableViewAnimationTypeOverTurn
- (void)overTurnAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = self.visibleCells;
    
    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.3;
    
    NSTimeInterval delayTime = 0.7;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 0.0;
        
        cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:0 animations:^{
            
            cell.layer.opacity = 1.0;
            
            cell.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

- (void)hiddenOverTurnAnimationCompletion:(CompletionHandler)completion
{
    NSArray<UITableViewCell *> *cells = [[self.visibleCells reverseObjectEnumerator] allObjects];

    if (cells.count<=0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    __block NSInteger count = 0;
    
    NSTimeInterval durationTime = 0.3;
    
    NSTimeInterval delayTime = 0.7;
    
    for (int i = 0; i < cells.count; i++) {
        
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        cell.layer.opacity = 1.0;
        
        cell.layer.transform = CATransform3DIdentity;
        
        [UIView animateWithDuration:durationTime delay:i*(delayTime/cells.count) options:0 animations:^{
            
            cell.layer.opacity = 0.0;
            
            cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
            
        } completion:^(BOOL finished) {
            count++;
            if (count == cells.count) {
                if (completion) {
                    completion(YES);
                }
            }
        }];
    }
}

@end
