//
//  UIViewController+ContainerViewHelpers.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "UIViewController+ContainerViewHelpers.h"

@implementation UIViewController (ContainerViewHelpers)

- (void)addChild:(UIViewController *)child {
    [self addChildViewController:child];
    child.view.frame = self.view.bounds;
    child.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:child.view];
    [child didMoveToParentViewController:self];
}

- (void)removeFromParent {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
