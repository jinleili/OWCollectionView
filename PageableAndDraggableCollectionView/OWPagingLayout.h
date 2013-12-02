//
//  PagingLayout.h
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWPagingLayout : UICollectionViewLayout
{
    CGSize  contentSize;
    UIEdgeInsets    sectionInset;
    
    float       rowGap, lineGap;
    
}
@property (nonatomic, strong) NSIndexPath   *hiddenIndexPath;
@property (strong, nonatomic) NSIndexPath   *fromIndexPath;
@property (strong, nonatomic) NSIndexPath   *toIndexPath;

@property (nonatomic, assign) uint      pageCount;
@property (nonatomic, assign) CGSize    itemSize;
@property (nonatomic, assign) int       cellCount;

@end
