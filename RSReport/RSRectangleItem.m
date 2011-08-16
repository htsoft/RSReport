//
//  RSRectangleItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSRectangleItem.h"

@implementation RSRectangleItem

@synthesize fillRect = _fillRect;
@synthesize lineWidth = _lineWidth;
@synthesize cornerRadius = _cornerRadius;

- (id)init
{
    self = [super init];
    if (self) {
        _lineWidth = 1.0;
        _cornerRadius = 0;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:_absoluteRect cornerRadius:_cornerRadius];
    bp.lineWidth = _lineWidth;
    [bp stroke];
    if (_fillRect) {
        [bp fill];
    }
}


@end
