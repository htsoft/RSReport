//
//  RSLineItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSLineItem.h"

@implementation RSLineItem

@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;
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
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = _lineWidth;
    [bp moveToPoint:_startPoint];
    [bp addLineToPoint:_endPoint];
    [bp stroke];
}

@end