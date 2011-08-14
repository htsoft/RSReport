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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    if (_image) {
        [_image drawInRect:self.frame];
    }
}


@end
