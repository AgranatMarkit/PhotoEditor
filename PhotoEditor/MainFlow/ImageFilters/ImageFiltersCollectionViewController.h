//
//  ImageFiltersCollectionViewController.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ImageFilterService;
@class ImageFilter;

typedef void(^OnSelectFilter)(ImageFilter *selectedFilter);

@interface ImageFiltersCollectionViewController : UICollectionViewController

@property (nonatomic) OnSelectFilter onSelectFilter;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)imageFiltersViewControllerWith:(ImageFilterService *)imageFilterService;

@end
