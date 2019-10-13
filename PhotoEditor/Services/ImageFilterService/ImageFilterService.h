//
//  ImageFilterService.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageFilter, UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface ImageFilterService : NSObject

- (void)obtainAvailableFilters:(void (^)(NSArray<ImageFilter *> *availableFilters))callback;
- (void)applyFilter:(ImageFilter *)filter onImage:(UIImage *)image withCallback:(void (^)(UIImage * _Nonnull))callback;

@end

NS_ASSUME_NONNULL_END
