//
//  RSPageFooter.m
//  RSReport
//
//  Created by Roberto Scarciello on 19/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSPageFooter.h"

@implementation RSPageFooter

@synthesize printOnLastPage = _printOnLastPage;

- (id)init
{
    self = [super init];
    if (self) {
        _printOnLastPage = NO;
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    if ([self.delegate getCurrentPageNumber]>=0) {
        CGRect originalFrame = self.frame;
        CGRect pageSize = [self.delegate getCurrentPageSize];
        
        // The Page Footer is always positioned at the bottom left corner
        self.frame = CGRectMake(0, pageSize.size.height - originalFrame.size.height, originalFrame.size.width, originalFrame.size.height);
        [super printSectionWithContext:context];
        // Back to the original position
        self.frame = originalFrame;
    }
}

@end
