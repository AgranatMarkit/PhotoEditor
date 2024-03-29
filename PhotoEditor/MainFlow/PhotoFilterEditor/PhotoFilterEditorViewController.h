//
//  PhotoFilterEditorViewController.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageFilterService;

/// Filter Editor.
/// Contain:
/// - Filter list allow select and apply filter.
/// - Repick button allow return to photo picker.
/// - Share button share edited image.
@interface PhotoFilterEditorViewController : UIViewController

@property (nonatomic) void (^onRepick)(void);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)photoFilterEditorWithImage:(UIImage *)image andImageFilterService:(ImageFilterService *)imageFilterService;

@end
