//
//  RSImageItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSImageItem.h"

@implementation RSImageItem

@synthesize image = _image;
@synthesize attribute = _attribute;
@synthesize defaultImage = _defaultImage;

- (id)init
{
    self = [super init];
    if (self) {
        _image = nil;
        _attribute = nil;
        _defaultImage = nil;
    }
    
    return self;
}

- (id)initWithDefaultImage:(UIImage *)defaultImage forAttribute:(NSString *)attribute
{
    self = [super init];
    if(self) {
        _image = nil;
        _attribute = attribute;
        _defaultImage = defaultImage;
    }
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    if(!self.image) {
        NSString *value = [[self.delegate getDataSource] getAttributeByPath:_attribute];
        self.image = [UIImage imageWithContentsOfFile:value];
        if(!self.image)
            self.image = self.defaultImage;
    }
    if(self.image) {
        [super printItemInContext:context];
        [self.image drawInRect:self.absoluteRect];
    }
}

@end
