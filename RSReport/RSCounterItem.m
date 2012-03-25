//
//  RSCounterItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 21/03/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSCounterItem.h"

@interface RSCounterItem ()

@property NSInteger counter;

@end

@implementation RSCounterItem

@synthesize counter = _counter;

- (id)init
{
    self = [super init];
    if (self)
    {
        _counter = 0;
    }
    return self;
}

- (void)setStartValue:(NSInteger)startValue 
{
    _counter = startValue-1;
}

- (NSInteger)getCurrentValue 
{
    return  _counter;
}

- (void)printItemInContext:(CGContextRef)context {
    ++_counter;
    self.text = [NSString stringWithFormat:@"%d",_counter];
    [super printItemInContext:context];
}

@end
