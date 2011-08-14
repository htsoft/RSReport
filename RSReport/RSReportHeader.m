//
//  RSReportHeader.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSReportHeader.h"
#import "RSGenericItem.h"

@implementation RSReportHeader

@synthesize printableItems = _printableItems;
@synthesize frame = _frame;

- (id)init
{
    self = [super init];
    if (self) {
        _printableItems = [NSMutableArray array];
    }
    
    return self;
}

- (void)printHeaderWithContext:(CGContextRef)context {
    for (RSGenericItem *gi in _printableItems) {
        [gi printItemInContext:context];
    } 
}

@end
