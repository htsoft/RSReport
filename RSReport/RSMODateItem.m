//
//  RSMODateItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 09/02/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSMODateItem.h"

@implementation RSMODateItem

@synthesize attribute = _attribute;
@synthesize dateFormat = _dateFormat;

- (id)init
{
    self = [super init];
    if (self) {
        _attribute = nil;
        _dateFormat = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getManagedObject] valueForKey:_attribute];
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    if (_dateFormat) {
        [dtFormat setDateFormat:_dateFormat];
    } else {
        [dtFormat setLocale:[NSLocale currentLocale]];
        [dtFormat setDateStyle:NSDateFormatterMediumStyle];        
    }
    if ([value isKindOfClass:[NSDate class]]) {
        self.text = [dtFormat stringFromDate:(NSDate *)value];
    } else {
        self.text = @"--/--/----";
    }
    [dtFormat release];
    [super printItemInContext:context];
}

@end
