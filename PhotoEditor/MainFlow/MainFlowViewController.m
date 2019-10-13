//
//  MainFlowViewController.m
//  PhotoEditor
//
//  Created by Марк on 12/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "MainFlowViewController.h"
#import "PhotoPickerViewController.h"
#import "UIViewController+ContainerViewHelpers.h"

@interface MainFlowViewController ()

@end

@implementation MainFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self presentImagePicker];
}

- (void)presentImagePicker {
    __weak __typeof(self) weakSelf = self;
    PhotoPickerViewController *photoPickerViewController = [PhotoPickerViewController pickerWithOnImagePick:^(UIImage *pickedImage) {
        __typeof(self) self = weakSelf;
        [self presentImageFilterEditorWithImage:pickedImage];
    }];
    [self addChild:photoPickerViewController];
}

- (void)presentImageFilterEditorWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = UIColor.whiteColor;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = self.view.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
    });
}

@end
