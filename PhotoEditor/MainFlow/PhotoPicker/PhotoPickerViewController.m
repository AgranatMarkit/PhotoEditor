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

@interface PhotoPickerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) OnImagePick onImagePick;
@property (nonatomic) UIView *previewView;
@property (nonatomic) UIButton *takePhotoButton;
@property (nonatomic) UIButton *openGalleryButton;
@property (nonatomic) PhotoPreviewViewController *photoPreviewViewController;

@end

@implementation PhotoPickerViewController

+ (instancetype)pickerWithOnImagePick:(OnImagePick)onImagePick {
    PhotoPickerViewController *photoPickerViewController = PhotoPickerViewController.new;
    photoPickerViewController.onImagePick = onImagePick;
    return photoPickerViewController;
}

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
    self.openGalleryButton.layer.cornerRadius = CGRectGetHeight(self.openGalleryButton.bounds) / 2;
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.blackColor;
    
    self.previewView = UIView.new;
    
    self.takePhotoButton = UIButton.new;
    [self.takePhotoButton setBackgroundColor:UIColor.whiteColor];
    [self.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.openGalleryButton = UIButton.new;
    [self.openGalleryButton setBackgroundColor:UIColor.whiteColor];
    [self.openGalleryButton setImage:[UIImage imageNamed:@"Gallery"] forState:UIControlStateNormal];
    [self.openGalleryButton addTarget:self action:@selector(openGallery) forControlEvents:UIControlEventTouchUpInside];
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
    
    self.openGalleryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.openGalleryButton];
    NSLayoutConstraint *openGalleryButtonLeading = [self.openGalleryButton.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8.f];
    NSLayoutConstraint *openGalleryButtonHeight = [self.openGalleryButton.heightAnchor constraintEqualToAnchor:self.takePhotoButton.heightAnchor];
    NSLayoutConstraint *openGalleryButtonWidth = [self.openGalleryButton.widthAnchor constraintEqualToAnchor:self.takePhotoButton.widthAnchor];
    NSLayoutConstraint *openGalleryButtonCenterY = [self.openGalleryButton.centerYAnchor constraintEqualToAnchor:self.takePhotoButton.centerYAnchor];
    
    [NSLayoutConstraint activateConstraints:@[
        previewViewLeading,
        previewViewTop,
        previewViewTrailing,
        takePhotoButtonTop,
        takePhotoButtonBottom,
        takePhotoButtonCenterX,
        takePhotoButtonHeight,
        takePhotoButtonWidth,
        openGalleryButtonLeading,
        openGalleryButtonHeight,
        openGalleryButtonWidth,
        openGalleryButtonCenterY
    ]];
}

- (void)takePhoto {
    __weak __typeof(self) weakSelf = self;
    [self.photoPreviewViewController obtainImageData:^(NSData * _Nonnull imageData) {
        __typeof(self) self = weakSelf;
        if (self.onImagePick)
            self.onImagePick([UIImage imageWithData:imageData]);
    }];
}

#pragma mark - UIImagePicker

- (void)openGallery {
    UIImagePickerController *picker = UIImagePickerController.new;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        __typeof(self) self = weakSelf;
        if (self.onImagePick)
            self.onImagePick(info[UIImagePickerControllerOriginalImage] ?: UIImage.new);
    }];
}

@end
