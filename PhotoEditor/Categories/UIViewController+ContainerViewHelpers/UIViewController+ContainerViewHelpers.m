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
    [self addChild:child toContainerView:self.view];
}

- (void)addChild:(UIViewController *)child toContainerView:(UIView *)containerView {
    [self addChildViewController:child];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    child.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:child.view];
    [child.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor].active = YES;
    [child.view.topAnchor constraintEqualToAnchor:containerView.topAnchor].active = YES;
    [child.view.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor].active = YES;
    [child.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor].active = YES;
    [child didMoveToParentViewController:self];
}

- (void)removeFromParent {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
