//
//  DemoViewController.m
//  PageableAndDraggableCollectionView
//
//  Created by grenlight on 13-11-28.
//  Copyright (c) 2013年 oowwww. All rights reserved.
//

#import "DemoViewController.h"
#import "OWPagingLayout.h"
#import "DemoCell.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    dataSource = [@[@"icon_20", @"icon_21", @"icon_22", @"icon_16",
                    @"icon_17", @"icon_18", @"icon_19",@"icon_3",
                    @"icon_4", @"icon_5", @"icon_6", @"icon_7",
                    @"icon_8", @"icon_9", @"icon_10", @"icon_11",
                    @"icon_12", @"icon_13", @"icon_14", @"icon_15",
                     @"icon_0", @"icon_1", @"icon_2"] mutableCopy];
    OWPagingLayout *flowLayout = [[OWPagingLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(69, 85);
    flowLayout.cellCount = dataSource.count;
    
    [collectionView setCollectionViewLayout:flowLayout];
    [collectionView registerNib:[UINib nibWithNibName:@"DemoCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [collectionView setDraggable:YES];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.owDelegate = self;
}

- (void)dealloc
{
    collectionView.delegate = nil;
    collectionView.dataSource = nil;
    collectionView.owDelegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collection delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)theCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    DemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *cellData = dataSource[indexPath.item];
    [cell setIcon:cellData title:cellData];
    
    return cell;
}


- (void)collectionView:(OWCollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id cellData = [dataSource objectAtIndex:fromIndexPath.item];
    [dataSource removeObjectAtIndex:fromIndexPath.item];
    [dataSource insertObject:cellData atIndex:toIndexPath.item];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = floorf(scrollView.contentOffset.x/appWidth);
    [collectionView collectionViewPaged];
}
@end
