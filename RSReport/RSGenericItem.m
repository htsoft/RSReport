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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    // Attualmente questa versione non fa nulla
}

@end
