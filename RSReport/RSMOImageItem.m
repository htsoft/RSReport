//
//  RSMOImageItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 20/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSMOImageItem.h"

@implementation RSMOImageItem

@synthesize attribute = _attribute;
@synthesize defaultImage = _defaultImage;

- (id)init
{
    self = [super init];
    if (self) {
        _attribute = nil;
        _defaultImage = nil;
    }
    return self;
}

- (id)initWithDefaultImage:(UIImage *)defaultImage
{
    self = [super init];
    if(self) {
        _attribute = nil;
        _defaultImage = defaultImage;
    }
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSString *value = [[self.delegate getManagedObject] valueForKeyPath:_attribute];
    self.image = [UIImage imageWithContentsOfFile:value];
    if(!self.image)
        self.image = self.defaultImage;
    if(self.image)
        [super printItemInContext:context];
}

@end
