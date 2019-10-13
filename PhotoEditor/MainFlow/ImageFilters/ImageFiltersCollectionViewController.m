//
//  ImageFiltersCollectionViewController.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "ImageFiltersCollectionViewController.h"
#import "ImageFilterCollectionViewCell.h"
#import "ImageFilterService.h"
#import "ImageFilter.h"

@interface ImageFiltersCollectionViewController ()

@property (nonatomic) ImageFilterService *imageFilterService;
@property (nonatomic) NSArray<ImageFilter *> *imageFilters;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ImageFiltersCollectionViewController

static NSString * const reuseIdentifier = @"ImageFilterCollectionViewCell";

+ (instancetype)imageFiltersViewControllerWith:(ImageFilterService *)imageFilterService  {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    flowLayout.itemSize = CGSizeMake(100, 60);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ImageFiltersCollectionViewController *imageFiltersCollectionViewController = [[ImageFiltersCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    imageFiltersCollectionViewController.imageFilterService = imageFilterService;
    return imageFiltersCollectionViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:ImageFilterCollectionViewCell.class forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    __weak __typeof(self) weakSelf = self;
    [self.imageFilterService obtainAvailableFilters:^(NSArray<ImageFilter *> * _Nonnull availableFilters) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof(self) self = weakSelf;
            self.imageFilters = availableFilters;
            [self.collectionView reloadData];
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        });
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageFilters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell updateWithImageFilter:self.imageFilters[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onSelectFilter)
        self.onSelectFilter(self.imageFilters[indexPath.row]);
}

@end
