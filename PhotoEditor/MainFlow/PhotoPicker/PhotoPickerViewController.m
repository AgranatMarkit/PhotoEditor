//
//  PhotoPickerViewController.m
//  PhotoEditor
//
//  Created by Марк on 12/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import "PhotoPreviewViewController.h"
#import "UIViewController+ContainerViewHelpers.h"

@interface PhotoPickerViewController ()

@property (nonatomic) UIView *previewView;
@property (nonatomic) UIButton *takePhotoButton;
@property (nonatomic) PhotoPreviewViewController *photoPreviewViewController;

@end

@implementation PhotoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupLayout];
    self.photoPreviewViewController = PhotoPreviewViewController.new;
    [self addChild:self.photoPreviewViewController toContainerView:self.previewView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.takePhotoButton.layer.cornerRadius = CGRectGetHeight(self.takePhotoButton.bounds) / 2;
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.greenColor;
    
    UIView *previewView = UIView.new;
    self.previewView = previewView;
    previewView.backgroundColor = UIColor.redColor;
    
    UIButton *takePhotoButton = UIButton.new;
    self.takePhotoButton = takePhotoButton;
    [self.takePhotoButton setBackgroundColor:UIColor.whiteColor];
    [self.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupLayout {
    self.previewView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.previewView];
    NSLayoutConstraint *previewViewLeading = [self.previewView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor];
    NSLayoutConstraint *previewViewTop = [self.previewView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
    NSLayoutConstraint *previewViewTrailing = [self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.previewView.trailingAnchor];

    
    self.takePhotoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.takePhotoButton];
    NSLayoutConstraint *takePhotoButtonTop = [self.takePhotoButton.topAnchor constraintEqualToAnchor:self.previewView.bottomAnchor constant:8.f];
    NSLayoutConstraint *takePhotoButtonBottom = [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.takePhotoButton.bottomAnchor constant:8.f];
    NSLayoutConstraint *takePhotoButtonCenterX = [self.takePhotoButton.centerXAnchor constraintEqualToAnchor:self.previewView.centerXAnchor];
    NSLayoutConstraint *takePhotoButtonHeight = [self.takePhotoButton.heightAnchor constraintEqualToConstant:60.f];
    NSLayoutConstraint *takePhotoButtonWidth = [self.takePhotoButton.widthAnchor constraintEqualToConstant:60.f];
    
    [NSLayoutConstraint activateConstraints:@[
        previewViewLeading,
        previewViewTop,
        previewViewTrailing,
        takePhotoButtonTop,
        takePhotoButtonBottom,
        takePhotoButtonCenterX,
        takePhotoButtonHeight,
        takePhotoButtonWidth]];
}

- (void)takePhoto {
    __weak __typeof(self) weakSelf = self;
    [self.photoPreviewViewController obtainImageData:^(NSData * _Nonnull imageData) {
        __typeof(self) self = weakSelf;
        [self didObtainImageData:imageData];
    }];
}

- (void)didObtainImageData:(NSData *)imageData {
    UIImage *img = [UIImage imageWithData:imageData];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
    });
}

@end
