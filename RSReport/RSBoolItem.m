//
//  RSBoolItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSBoolItem.h"

@implementation RSBoolItem

@synthesize value = _value;

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
    else
        currentValue = self.value;
    if ([currentValue isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)currentValue) boolValue]) {
            self.text = @"ON";
        } else {
            self.text = @"OFF";
        }
    }
    [super printItemInContext:context];
}

@end
