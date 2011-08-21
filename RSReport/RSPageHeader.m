//
//  RSPageHeader.m
//  RSReport
//
//  Created by Roberto Scarciello on 19/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSPageHeader.h"

@implementation RSPageHeader

@synthesize printOnFirstPage = _printOnFirstPage;

- (id)init
{
    self = [super init];
    if (self) {
        _printOnFirstPage = NO;
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    if ([self.delegate getCurrentPageNumber]>0 || _printOnFirstPage) {
        CGRect originalFrame = self.frame;
        // The Page Header is always positioned at the top left corner
        self.frame = CGRectMake(0, 0, originalFrame.size.width, originalFrame.size.height);
        [super printSectionWithContext:context];
        // Back to the original position
        self.frame = originalFrame;
    }
}


@end
