//
//  RSMOCurrencyItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 08/02/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSMOCurrencyItem.h"

@implementation RSMOCurrencyItem

@synthesize attribute = _attribute;

- (id)init
{
    self = [super init];
    if (self) {
        _attribute = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getManagedObject] valueForKey:_attribute];
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setLocale:[NSLocale currentLocale]];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
    if ([value isKindOfClass:[NSNumber class]]) {
        self.text = [numFmt stringFromNumber:(NSNumber *)value];
    } else {
        self.text = @"NaN";
    }
    [numFmt release];
    [super printItemInContext:context];
}

@end
