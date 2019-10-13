//
//  ImageFilter.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "ImageFilter.h"

#define kNoneFilter @"None"

@implementation ImageFilter

- (BOOL)isNone {
    return [self.value isEqualToString:kNoneFilter];
}

+ (instancetype)none {
    return [[ImageFilter alloc] initWithName:@"None" andValue:kNoneFilter];
}

+ (instancetype)filterWithName:(NSString *)name andValue:(NSString *)value {
    return [[ImageFilter alloc] initWithName:name andValue:value];
}

- (instancetype)initWithName:(NSString *)name andValue:(NSString *)value {
    self = [super init];
    if (self) {
        _name = name;
        _value = value;
    }
    return self;
}

@end
