//
//  ImageFilterService.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "ImageFilterService.h"
#import "ImageFilter.h"

@import UIKit;

@interface ImageFilterService ()

@property (nonatomic) dispatch_queue_t imageServiceQueue;
@property (nonatomic) NSArray<ImageFilter *> *imageFilters;

@end

@implementation ImageFilterService

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageServiceQueue = dispatch_queue_create("com.PhotoEditor.ImageServiceQueue", NULL);
        _imageFilters = @[
            [ImageFilter filterWithName:@"None" andValue:@"None"],
            [ImageFilter filterWithName:@"Box Blur" andValue:@"CIBoxBlur"],
            [ImageFilter filterWithName:@"Color Invert" andValue:@"CIColorInvert"],
            [ImageFilter filterWithName:@"Fade" andValue:@"CIPhotoEffectFade"],
            [ImageFilter filterWithName:@"Chrome" andValue:@"CIPhotoEffectChrome"],
        ];
    }
    return self;
}

- (void)obtainAvailableFilters:(void (^)(NSArray<ImageFilter *> * _Nonnull))callback {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.imageServiceQueue, ^{
        __typeof(self) self = weakSelf;
        callback(self.imageFilters);
    });
}

- (void)applyFilter:(ImageFilter *)filter onImage:(UIImage *)image withCallback:(void (^)(UIImage *newImage))callback {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.imageServiceQueue, ^{
        __typeof(self) self = weakSelf;
        callback([self addFilter:filter toImage:image]);
    });
}

- (UIImage *)addFilter:(ImageFilter *)filter toImage:(UIImage *)image {
    if (filter.isNone) return image;
    CIContext *context = CIContext.context;
    CIFilter *ciFilter = [CIFilter filterWithName:filter.value];
    [ciFilter setValue:[CIImage imageWithCGImage:image.CGImage] forKey:@"inputImage"];
    CIImage *outputImage = ciFilter.outputImage;
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *result = [UIImage imageWithCGImage:cgImage scale:1.f orientation:image.imageOrientation];
    CGImageRelease(cgImage);
    return result;
}

@end
