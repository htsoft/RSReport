//
//  RSSumItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSSumItem.h"

@interface RSSumItem ()

@property (nonatomic, strong) NSNumber *currentSum;

@end

@implementation RSSumItem

@synthesize isCurrency = _isCurrency;
@synthesize currentSum = _currentSum;
@synthesize locale = _locale;

- (id)init
{
    self = [super init];
    if (self) {
        _isCurrency = NO;
        _currentSum = [NSNumber numberWithDouble:0];
        _locale = nil;
    }
    
    return self;
}

- (void)evaluate {
    NSObject *value = [[self.delegate getManagedObject] valueForKeyPath:self.attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        NSLog(@"Called evaluate...");
        double sum = [_currentSum doubleValue] + [((NSNumber *)value) doubleValue];
        _currentSum = [NSNumber numberWithDouble:sum];
    }
}

- (void)printItemInContext:(CGContextRef)context {
    if (_isCurrency) {
        if(!self.locale)
            self.locale = [NSLocale currentLocale];
        NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
        [numFmt setLocale:self.locale];
        [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.text = [numFmt stringFromNumber:_currentSum];
    } else {
        self.text = [_currentSum stringValue];
    }
    [super printItemInContext:context];
}

@end
