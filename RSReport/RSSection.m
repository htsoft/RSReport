//
//  RSSection.m
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSSection.h"

@implementation RSSection

@synthesize delegate = _delegate;
@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;
@synthesize frame = _frame;

- (id)init
{
    self = [super init];
    if (self) {
        _fillColor = [UIColor whiteColor];
        _strokeColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    // Must be extended with drawings of borders and fill area
}

@end
