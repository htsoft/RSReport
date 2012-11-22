//
//  RSBoolItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSBoolItem.h"

@implementation RSBoolItem

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)value) boolValue]) {
            self.text = @"ON";
        } else {
            self.text = @"OFF";
        }
    }
    [super printItemInContext:context];
}

@end
