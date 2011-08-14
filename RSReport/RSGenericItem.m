//
//  RSGenericItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSGenericItem.h"

@implementation RSGenericItem

@synthesize frame = _frame;
@synthesize strokeColor = _strokeColor;
@synthesize fillColor = _fillColor;

- (id)init
{
    self = [super init];
    if (self) {
        _strokeColor = [UIColor blackColor];
        _fillColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [_strokeColor setStroke];
    [_fillColor setFill];
}

@end
