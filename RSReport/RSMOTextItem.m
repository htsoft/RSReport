//
//  RSMOTextItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSMOTextItem.h"

@implementation RSMOTextItem

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
    if ([value isKindOfClass:[NSString class]])
        self.text = (NSString *)value;
    if ([value isKindOfClass:[NSNumber class]]) {
        self.text = [((NSNumber *)value) stringValue];
    }
    [super printItemInContext:context];
}

@end
