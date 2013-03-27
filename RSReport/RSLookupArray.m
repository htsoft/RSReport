//
//  RSLookupArray.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSLookupArray.h"

@implementation RSLookupArray

@synthesize lookupArray = _lookupArray;
@synthesize defaultValue = _defaultValue;

- (id)init
{
    self = [super init];
    if (self) {
        _defaultValue = @"";
        _lookupArray = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        if(self.lookupArray) {
            NSInteger indice = [(NSNumber *)value integerValue];
            if(indice<0 || indice>=[self.lookupArray count]) {
                self.text = self.defaultValue;
            } else {
                self.text = (NSString *)[self.lookupArray objectAtIndex:indice];
            }
        } else {
            self.text = self.defaultValue;
        }
    } else {
        self.text = self.defaultValue;
    }
    [super printItemInContext:context];
}

@end
