//
//  DemoViewController.h
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWCollectionView.h"

@interface DemoViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,
OWCollectionViewDelegate>
{
    IBOutlet    OWCollectionView    *collectionView;
    IBOutlet UIPageControl  *pageControl;
    
    NSMutableArray     *dataSource;

}
@end
