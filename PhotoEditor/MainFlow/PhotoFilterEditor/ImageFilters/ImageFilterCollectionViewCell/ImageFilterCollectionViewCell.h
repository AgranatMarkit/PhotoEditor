//
//  ImageFilterCollectionViewCell.h
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageFilter;

NS_ASSUME_NONNULL_BEGIN

@interface ImageFilterCollectionViewCell : UICollectionViewCell

- (void)updateWithImageFilter:(ImageFilter *)imageFilter;

@end

NS_ASSUME_NONNULL_END
