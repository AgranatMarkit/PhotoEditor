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
    [NSLayoutConstraint activateConstraints:@[
        [child.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [child.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [child.view.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [child.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]
    ]];
    [child didMoveToParentViewController:self];
}

- (void)removeFromParent {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)flipFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC completion:(void (^)(void))completion {
    if (!oldVC) {
        [self addChild:newVC];
        completion();
        return;
    }
    
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    newVC.view.frame = oldVC.view.bounds;
    
    __weak __typeof(self) weakSelf = self;
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{} completion:^(BOOL finished) {
        __typeof(self) self = weakSelf;
        
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        newVC.view.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [newVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [newVC.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [newVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [newVC.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
        ]];
        
        [oldVC removeFromParentViewController];
        [newVC didMoveToParentViewController:self];
        
        if (completion) completion();
    }];
}

@end
