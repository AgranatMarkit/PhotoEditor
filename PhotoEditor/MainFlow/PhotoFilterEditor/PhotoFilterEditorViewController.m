//
//  PhotoFilterEditorViewController.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "PhotoFilterEditorViewController.h"
#import "ImageFilterService.h"
#import "ImageFilter.h"
#import "ImageFiltersCollectionViewController.h"

@interface PhotoFilterEditorViewController ()

@property (nonatomic) ImageFilterService *imageFilterService;
@property (nonatomic) UIImage *image;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) ImageFiltersCollectionViewController *imageFiltersCollectionViewController;
@property (nonatomic) UIButton *repickButton;
@property (nonatomic) UIButton *shareButton;

@end

@implementation PhotoFilterEditorViewController

+ (instancetype)photoFilterEditorWithImage:(UIImage *)image andImageFilterService:(ImageFilterService *)imageFilterService {
    PhotoFilterEditorViewController *photoFilterViewController = PhotoFilterEditorViewController.new;
    photoFilterViewController.image = image;
    photoFilterViewController.imageFilterService = imageFilterService;
    return photoFilterViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.blackColor;
    
    self.imageView = UIImageView.new;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.image;
    
    self.imageFiltersCollectionViewController = [ImageFiltersCollectionViewController imageFiltersViewControllerWith:self.imageFilterService];
    __weak __typeof(self) weakSelf = self;
    self.imageFiltersCollectionViewController.onSelectFilter = ^(ImageFilter *selectedFilter) {
        __typeof(self) self = weakSelf;
        [self.imageFilterService applyFilter:selectedFilter onImage:self.image withCallback:^(UIImage * newImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __typeof(self) self = weakSelf;
                self.imageView.image = newImage;
            });
        }];
    };
    
    self.repickButton = UIButton.new;
    [self.repickButton setTitle:@"Repick" forState:UIControlStateNormal];
    [self.repickButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.repickButton.backgroundColor = UIColor.whiteColor;
    self.repickButton.layer.cornerRadius = 8.f;
    [self.repickButton addTarget:self action:@selector(repick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareButton = UIButton.new;
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.shareButton.backgroundColor = UIColor.whiteColor;
    self.shareButton.layer.cornerRadius = 8.f;
    [self.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupConstraints {
    UIStackView *rootStackView = UIStackView.new;
    rootStackView.axis = UILayoutConstraintAxisVertical;
    rootStackView.distribution = UIStackViewDistributionFill;
    rootStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rootStackView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [rootStackView addArrangedSubview:self.imageView];
    
    UIView *imageFilterView = self.imageFiltersCollectionViewController.view;
    imageFilterView.translatesAutoresizingMaskIntoConstraints = NO;
    [rootStackView addArrangedSubview:imageFilterView];
    
    UIStackView *buttonsStackView = UIStackView.new;
    buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    buttonsStackView.distribution = UIStackViewDistributionFillEqually;
    buttonsStackView.spacing = 8.f;
    self.repickButton.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonsStackView addArrangedSubview:self.repickButton];
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonsStackView addArrangedSubview:self.shareButton];
    buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [rootStackView addArrangedSubview:buttonsStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [rootStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [rootStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [rootStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [rootStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [imageFilterView.heightAnchor constraintEqualToConstant:100.f],
        [buttonsStackView.heightAnchor constraintEqualToConstant:60.f]
    ]];
}

- (void)repick {
    if (self.onRepick)
        self.onRepick();
}

- (void)share {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
