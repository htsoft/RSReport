//
//  RSMOTextItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSMOTextItem.h"

@implementation RSMOTextItem

@synthesize delegate = _delegate;
@synthesize attribute = _attribute;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[_delegate getManagedObject] valueForKey:_attribute];
    if ([value isKindOfClass:[NSString class]])
        self.text = (NSString *)value;
    [super printItemInContext:context];
}

@end
