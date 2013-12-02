//
//  ApplicationCollectionCell.h
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.

#import <UIKit/UIKit.h>
#import "OWShakeableCVCell.h"

@interface DemoCell : OWShakeableCVCell
{
    IBOutlet UILabel           *titleLB;
    IBOutlet UIImageView        *iconView;
}

- (void)setIcon:(NSString *)iconName title:(NSString *)title;

@end
