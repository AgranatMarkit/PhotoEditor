//
//  PhotoFilterEditorViewController.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageFilterService;

@interface PhotoFilterEditorViewController : UIViewController

@property (nonatomic) void (^onRepick)(void);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)photoFilterEditorWithImage:(UIImage *)image andImageFilterService:(ImageFilterService *)imageFilterService;

@end
