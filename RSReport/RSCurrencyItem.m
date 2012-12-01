//
//  RSCurrencyItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSCurrencyItem.h"

@implementation RSCurrencyItem

@synthesize locale = _locale;
@synthesize value = _value;

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue = nil;
    if(!self.locale)
        self.locale = [NSLocale currentLocale];
    if (!self.value && self.attribute) 
        currentValue = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
    else 
        currentValue = self.value;
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setLocale:self.locale];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
    if ([currentValue isKindOfClass:[NSNumber class]]) {
        self.text = [numFmt stringFromNumber:(NSNumber *)currentValue];
    } else {
        self.text = @"NaN";
    }
    [super printItemInContext:context];
}

@end
