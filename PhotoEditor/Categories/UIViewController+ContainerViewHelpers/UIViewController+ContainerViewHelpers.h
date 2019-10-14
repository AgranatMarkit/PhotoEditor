//
//  UIViewController+ContainerViewHelpers.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ContainerViewHelpers)

- (void)addChild:(UIViewController *)child;
- (void)addChild:(UIViewController *)child toContainerView:(UIView *)containerView;
- (void)removeFromParent;
- (void)flipFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
