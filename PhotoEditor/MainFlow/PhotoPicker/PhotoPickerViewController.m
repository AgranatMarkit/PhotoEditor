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

static CGFloat const buttonSide = 60.f;

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

- (void)setupViews {
    self.view.backgroundColor = UIColor.blackColor;
    
    self.previewView = UIView.new;
    
    self.takePhotoButton = UIButton.new;
    [self.takePhotoButton setBackgroundColor:UIColor.whiteColor];
    [self.takePhotoButton setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [self.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    self.takePhotoButton.layer.cornerRadius = buttonSide / 2;
    
    self.openGalleryButton = UIButton.new;
    [self.openGalleryButton setBackgroundColor:UIColor.whiteColor];
    [self.openGalleryButton setImage:[UIImage imageNamed:@"Gallery"] forState:UIControlStateNormal];
    [self.openGalleryButton addTarget:self action:@selector(openGallery) forControlEvents:UIControlEventTouchUpInside];
    self.openGalleryButton.layer.cornerRadius = buttonSide / 2;
}

- (void)setupLayout {
    self.previewView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.previewView];

    UIStackView *buttonsStackView = UIStackView.new;
    buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    buttonsStackView.distribution = UIStackViewDistributionFill;
    buttonsStackView.spacing = 8.f;
    buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:buttonsStackView];
    
    self.takePhotoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonsStackView addArrangedSubview:self.takePhotoButton];
    
    self.openGalleryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonsStackView addArrangedSubview:self.openGalleryButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.previewView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.previewView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.previewView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [buttonsStackView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
        [buttonsStackView.topAnchor constraintEqualToAnchor:self.previewView.bottomAnchor constant:8.f],
        [buttonsStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8.f],
        [self.takePhotoButton.heightAnchor constraintEqualToConstant:buttonSide],
        [self.takePhotoButton.widthAnchor constraintEqualToConstant:buttonSide],
        [self.openGalleryButton.heightAnchor constraintEqualToConstant:buttonSide],
        [self.openGalleryButton.widthAnchor constraintEqualToConstant:buttonSide],
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
