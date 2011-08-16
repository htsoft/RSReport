//
//  RSReportHeader.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSReportHeader.h"

@implementation RSReportHeader

@synthesize newPageAfterPrint = _newPageAfterPrint;

- (id)init
{
    self = [super init];
    if (self) {
        _newPageAfterPrint = NO;
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    [super printSectionWithContext:context];
    
    if (_newPageAfterPrint && [self.delegate respondsToSelector:@selector(updateCurrentPage)])
        [self.delegate updateCurrentPage];
}

@end
