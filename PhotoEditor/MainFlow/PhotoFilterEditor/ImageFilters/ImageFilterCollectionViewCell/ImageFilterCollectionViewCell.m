//
//  ImageFilterCollectionViewCell.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "ImageFilterCollectionViewCell.h"
#import "ImageFilter.h"

@interface ImageFilterCollectionViewCell ()

@property (nonatomic) UILabel *textLabel;

@end

@implementation ImageFilterCollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.contentView.backgroundColor = selected ? UIColor.lightGrayColor : UIColor.whiteColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.textLabel = UILabel.new;
        self.textLabel.backgroundColor = UIColor.clearColor;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.numberOfLines = 0;
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)updateWithImageFilter:(ImageFilter *)imageFilter {
    self.textLabel.text = imageFilter.name;
    self.textLabel.frame = self.contentView.bounds;
}

@end
