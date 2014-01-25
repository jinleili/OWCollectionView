//
//  PagingLayout.m
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import "OWPagingLayout.h"

#define MAX_PAGE_ITEMS 12

@implementation OWPagingLayout

-(void)prepareLayout
{
    [super prepareLayout];

    CGSize size = self.collectionView.frame.size;
    self.pageCount = ceil((float)self.cellCount/MAX_PAGE_ITEMS);
    contentSize = CGSizeMake(appWidth * self.pageCount, size.height);
    sectionInset = UIEdgeInsetsMake(32, 11, 32, 11);
    rowGap = (appWidth - self.itemSize.width * 4 - sectionInset.left * 2)/3.0f;
    lineGap = 10;
}

-(CGSize)collectionViewContentSize
{
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = self.itemSize;
    int row = floorf(path.row/4.0f);
    int rowOffsetX = 0;
    if (row > 2) {
        int pageIndex = ceil((path.row+1)/12.0f)-1;
        row -= pageIndex*3;
        rowOffsetX = pageIndex*appWidth;
    }
    
    int rowIndex = path.row%4;
    
    attributes.center = CGPointMake(rowOffsetX +
                                    sectionInset.left + self.itemSize.width*(rowIndex+ 0.5) + rowGap*rowIndex,
                                    sectionInset.top + self.itemSize.height*(row+0.5) + lineGap * row);
    if (self.hiddenIndexPath && [path isEqual:self.hiddenIndexPath])
        [attributes setHidden:YES];
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return [self modifiedLayoutAttributesForElements:attributes];
}

- (NSArray *)modifiedLayoutAttributesForElements:(NSArray *)elements
{
    UICollectionView *collectionView = self.collectionView;
    NSIndexPath *fromIndexPath = self.fromIndexPath;
    NSIndexPath *toIndexPath = self.toIndexPath;
    NSIndexPath *hideIndexPath = self.hiddenIndexPath;
    NSIndexPath *indexPathToRemove;
    
    if (toIndexPath == nil) {
        if (hideIndexPath == nil) {
            return elements;
        }
        for (UICollectionViewLayoutAttributes *layoutAttributes in elements) {
            if(layoutAttributes.representedElementCategory != UICollectionElementCategoryCell) {
                continue;
            }
            if ([layoutAttributes.indexPath isEqual:hideIndexPath]) {
                layoutAttributes.hidden = YES;
            }
        }
        return elements;
    }
    
    if (fromIndexPath.section != toIndexPath.section) {
        indexPathToRemove = [NSIndexPath indexPathForItem:[collectionView numberOfItemsInSection:fromIndexPath.section] - 1
                                                inSection:fromIndexPath.section];
    }
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in elements) {
        if(layoutAttributes.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        if([layoutAttributes.indexPath isEqual:indexPathToRemove]) {
            // Remove item in source section and insert item in target section
            layoutAttributes.indexPath = [NSIndexPath indexPathForItem:[collectionView numberOfItemsInSection:toIndexPath.section]
                                                             inSection:toIndexPath.section];
            if (layoutAttributes.indexPath.item != 0) {
                layoutAttributes.center = [self layoutAttributesForItemAtIndexPath:layoutAttributes.indexPath].center;
            }
        }
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        if ([indexPath isEqual:hideIndexPath]) {
            layoutAttributes.hidden = YES;
        }
        if([indexPath isEqual:toIndexPath]) {
            // Item's new location
            layoutAttributes.indexPath = fromIndexPath;
        }
        else if(fromIndexPath.section != toIndexPath.section) {
            if(indexPath.section == fromIndexPath.section && indexPath.item >= fromIndexPath.item) {
                // Change indexes in source section
                layoutAttributes.indexPath = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
            }
            else if(indexPath.section == toIndexPath.section && indexPath.item >= toIndexPath.item) {
                // Change indexes in destination section
                layoutAttributes.indexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
            }
        }
        else if(indexPath.section == fromIndexPath.section) {
            if(indexPath.item <= fromIndexPath.item && indexPath.item > toIndexPath.item) {
                // Item moved back
                layoutAttributes.indexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
            }
            else if(indexPath.item >= fromIndexPath.item && indexPath.item < toIndexPath.item) {
                // Item moved forward
                layoutAttributes.indexPath = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
            }
        }
    }
    
    return elements;
}


- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(0,0);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(0, 0);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

@end
