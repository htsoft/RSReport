//
//  RSMOAvgItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 05/06/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSMOAvgItem.h"

@interface RSMOAvgItem ()

@property (nonatomic, strong) NSNumber *currentSum;
@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation RSMOAvgItem

@synthesize attribute = _attribute;
@synthesize isCurrency = _isCurrency;
@synthesize currentSum = _currentSum;
@synthesize itemCount = _itemCount;

- (id)init
{
    self = [super init];
    if (self) {
        _attribute = nil;
        _isCurrency = NO;
        _currentSum = [NSNumber numberWithDouble:0];
        _itemCount = 0;
    }
    
    return self;
}

- (void)evaluate {
    NSObject *value = [[self.delegate getManagedObject] valueForKeyPath:_attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        NSLog(@"Called evaluate...");
        double sum = [_currentSum doubleValue] + [((NSNumber *)value) doubleValue];
        _currentSum = [NSNumber numberWithDouble:sum];
        ++_itemCount;
    }
}

- (void)printItemInContext:(CGContextRef)context {
    NSInteger currentItemCount = 0;
    if (_itemCount==0)
        currentItemCount = 1;
    else
        currentItemCount = _itemCount;
    NSNumber *average = [NSNumber numberWithDouble:[_currentSum doubleValue]/currentItemCount];
    if (_isCurrency) {
        NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
        [numFmt setLocale:[NSLocale currentLocale]];
        [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.text = [numFmt stringFromNumber:average];
    } else {
        self.text = [average stringValue];
    }
    [super printItemInContext:context];
}


@end
