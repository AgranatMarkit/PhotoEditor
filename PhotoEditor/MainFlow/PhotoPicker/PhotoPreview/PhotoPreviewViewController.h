//
//  PhotoPreviewViewController.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Display data from camera.
/// Allow obtain image data
@interface PhotoPreviewViewController : UIViewController

- (void)obtainImageData:(void (^)(NSData *imageData))callback;

@end

NS_ASSUME_NONNULL_END
