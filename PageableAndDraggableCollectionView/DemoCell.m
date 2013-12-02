//
//  ApplicationCollectionCell.m
//  LongYuanDigest
//
//  Created by 龙源 on 13-10-18.
//  Copyright (c) 2013年 longyuan. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setIcon:(NSString *)iconName title:(NSString *)title
{
    NSString *iconPath = [[NSBundle mainBundle] pathForResource:iconName ofType:@"png"];
    iconView.image = [UIImage imageWithContentsOfFile:iconPath];
    [titleLB setText:title];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5;
    }
    else {
        self.alpha = 1.f;
    }
}

@end
