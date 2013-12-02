//
//  ApplicationCollectionCell.h
//  LongYuanDigest
//
//  Created by 龙源 on 13-10-18.
//  Copyright (c) 2013年 longyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoCell : UICollectionViewCell
{
    IBOutlet UILabel           *titleLB;
    IBOutlet UIImageView        *iconView;
}

- (void)setIcon:(NSString *)iconName title:(NSString *)title;

@end
