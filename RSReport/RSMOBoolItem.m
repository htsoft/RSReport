//
//  RSMOBoolItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 19/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSMOBoolItem.h"

@implementation RSMOBoolItem

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
