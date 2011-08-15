//
//  RSBodySection.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSBodySection.h"
#import "RSGenericItem.h"

@implementation RSBodySection

@synthesize delegate = _delegate;
@synthesize printableItems = _printableItems;

- (id)init
{
    self = [super init];
    if (self) {
        _printableItems = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    [super printSectionWithContext:context];
    
    for (RSGenericItem *gi in _printableItems) {
        [gi printItemInContext:context];
    } 
    
    if ([self.delegate respondsToSelector:@selector(updateVPosition:)]) 
        [self.delegate updateVPosition:self.frame.size.height];
}


@end
