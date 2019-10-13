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
    PhotoPickerViewController *photoPickerViewController = PhotoPickerViewController.new;
    [self addChild:photoPickerViewController];
}

@end
