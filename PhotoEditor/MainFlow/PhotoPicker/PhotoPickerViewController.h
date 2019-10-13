//
//  PhotoPickerViewController.h
//  PhotoEditor
//
//  Created by Марк on 12/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnImagePick)(UIImage *pickedImage);

@interface PhotoPickerViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)pickerWithOnImagePick:(OnImagePick)onImagePick;

@end
