//
//  RSOvalItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSOvalItem.h"

@implementation RSOvalItem

@synthesize fillRect = _fillRect;
@synthesize lineWidth = _lineWidth;

- (id)init
{
    self = [super init];
    if (self) {
        _lineWidth = 1.0;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect:_absoluteRect];
    bp.lineWidth = _lineWidth;
    [bp stroke];
    if (_fillRect) {
        [bp fill];
    }
}

@end
