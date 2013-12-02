//
//  OWCollectionView.h
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWCollectionViewDelegate <NSObject>

@required
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@class OWPagingLayout;

@interface OWCollectionView : UICollectionView<UIGestureRecognizerDelegate>
{
    @private
    UIGestureRecognizer *longPressGestureRecognizer;
    UIGestureRecognizer *panPressGestureRecognizer;
    BOOL                _draggable;
    
    UIImageView         *mockCell;
    CGPoint             mockCenter;
    
    OWPagingLayout      *layouter;
    uint                currentPage;
    
    //正在执行翻页动画其间，不应检测是否翻页;
    BOOL                isPaging;
    
    //没有长按cell的动作，不需要检测cell的移动
    BOOL                isInLongPress;
}
@property (nonatomic, assign) id<OWCollectionViewDelegate> owDelegate;
@property (nonatomic, assign) BOOL draggable;

//产生了翻页后， visibleCells发生了变化，need reset shake animation.
- (void)collectionViewPaged;

@end
