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
@property (nonatomic, weak) PhotoPickerViewController *photoPickerViewController;
@property (nonatomic, weak) PhotoFilterEditorViewController *photoFilterEditorViewController;

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
        __typeof(self) self = weakSelf;
        [self presentImageFilterEditorWithImage:pickedImage];
        [self.photoPickerViewController removeFromParent];
    }];
    self.photoPickerViewController = photoPickerViewController;
    [self addChild:photoPickerViewController];
}

- (void)presentImageFilterEditorWithImage:(UIImage *)image {
    PhotoFilterEditorViewController *photoFilterEditor = [PhotoFilterEditorViewController photoFilterEditorWithImage:image andImageFilterService:self.imageFilterService];
    __weak __typeof(self) weakSelf = self;
    photoFilterEditor.onRepick = ^{
        __typeof(self) self = weakSelf;
        [self presentImagePicker];
        [self.photoFilterEditorViewController removeFromParent];
    };
    self.photoFilterEditorViewController = photoFilterEditor;
    [self addChild:photoFilterEditor];
}

@end
