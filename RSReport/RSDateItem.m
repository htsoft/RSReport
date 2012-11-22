//
//  RSDateItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSDateItem.h"

@implementation RSDateItem

@synthesize dateFormat = _dateFormat;

- (id)init
{
    self = [super init];
    if (self) {
        _dateFormat = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
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
    [super printItemInContext:context];
}

@end
