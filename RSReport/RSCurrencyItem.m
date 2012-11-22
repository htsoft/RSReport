//
//  RSCurrencyItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSCurrencyItem.h"

@implementation RSCurrencyItem

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setLocale:[NSLocale currentLocale]];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
    if ([value isKindOfClass:[NSNumber class]]) {
        self.text = [numFmt stringFromNumber:(NSNumber *)value];
    } else {
        self.text = @"NaN";
    }
    [super printItemInContext:context];
}

@end
