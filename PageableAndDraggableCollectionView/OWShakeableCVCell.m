//
//  OWShakeableCVCell.m
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import "OWShakeableCVCell.h"

@implementation OWShakeableCVCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor blackColor];
    isShaking = NO;
    isInPressing = NO;
}

- (void)dealloc
{
}

- (void)startShake
{
    if (isInPressing) return;
    
    isShaking = YES;
    scale = 0.9;
    
    //生成一个－5 ～ 5 之间的旋转角度值
    void(^calculateDegress)() = ^{
        shakeDegress = (arc4random() % 11) - 5;
    };
    calculateDegress();
    
    if (shakeDegress == 0)
        calculateDegress();
    
    CGAffineTransform trancform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-shakeDegress));
    trancform = CGAffineTransformScale(trancform, scale, scale);
    
    void(^completion)(BOOL) = ^(BOOL finished){
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                         animations:^ {
                             self.transform = CGAffineTransformRotate(trancform, RADIANS(shakeDegress));
                         }
                         completion:NULL
         ];
    };
    
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = trancform;
    } completion:completion];
    
}

- (void)stopShake
{
    NSLog(@"stopShake");

    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^ {
                         self.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL bl){
                         isShaking = NO;
                     }
     ];
}

- (void)pressScale:(float)scaleSize
{
    [UIView animateWithDuration:0.2 animations:^{
    }];

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^ {
                         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,scaleSize, scaleSize);
                     }
                     completion:^(BOOL bl){
                         if (scaleSize == 1 && isShaking)
                             [self startShake];
                     }
     ];
}

#pragma mark button && gesture event
@end
