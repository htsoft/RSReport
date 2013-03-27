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
@synthesize value = _value;

- (id)init
{
    self = [super init];
    if (self) {
        _dateFormat = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else
        currentValue = self.value;
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    if (_dateFormat) {
        [dtFormat setDateFormat:_dateFormat];
    } else {
        [dtFormat setLocale:[NSLocale currentLocale]];
        [dtFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    if ([currentValue isKindOfClass:[NSDate class]]) {
        self.text = [dtFormat stringFromDate:(NSDate *)currentValue];
    } else {
        self.text = @"--/--/----";
    }
    [super printItemInContext:context];
}

@end
