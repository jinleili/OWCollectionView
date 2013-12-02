//
//  OWShakeableCVCell.h
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@interface OWShakeableCVCell : UICollectionViewCell
{
    int shakeDegress;
    float scale;
    
    BOOL    isShaking, isInPressing;
    
}
- (void)isNeedsShake;

- (void)startShake;
- (void)stopShake;

@end


