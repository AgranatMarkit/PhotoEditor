//
//  MainFlowViewController.m
//  PhotoEditor
//
//  Created by Марк on 12/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "MainFlowViewController.h"
#import "PhotoPickerViewController.h"
#import "PhotoFilterEditorViewController.h"
#import "ImageFilterService.h"
#import "UIViewController+ContainerViewHelpers.h"

@interface MainFlowViewController ()

@property (nonatomic) ImageFilterService *imageFilterService;
@property (nonatomic, weak) UIViewController *displayedViewController;

@end

@implementation MainFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.imageFilterService = ImageFilterService.new;
    [self presentImagePicker];
}

- (void)presentImagePicker {
    __weak __typeof(self) weakSelf = self;
    PhotoPickerViewController *photoPickerViewController = [PhotoPickerViewController pickerWithOnImagePick:^(UIImage *pickedImage) {
        [weakSelf presentImageFilterEditorWithImage:pickedImage];
    }];
    [self flipFromViewController:self.displayedViewController toViewController:photoPickerViewController completion:^{
        weakSelf.displayedViewController = photoPickerViewController;
    }];
}

- (void)presentImageFilterEditorWithImage:(UIImage *)image {
    __weak __typeof(self) weakSelf = self;
    PhotoFilterEditorViewController *photoFilterEditor = [PhotoFilterEditorViewController photoFilterEditorWithImage:image andImageFilterService:self.imageFilterService];
    photoFilterEditor.onRepick = ^{
        [weakSelf presentImagePicker];
    };
    [self flipFromViewController:self.displayedViewController toViewController:photoFilterEditor completion:^{
        weakSelf.displayedViewController = photoFilterEditor;
    }];
}

@end
