//
//  RSTextItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@implementation RSTextItem

@synthesize text = _text;
@synthesize font = _font;

- (id)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGSize textSize = [_text sizeWithFont:_font constrainedToSize:self.frame.size lineBreakMode:UILineBreakModeClip];
    CGRect textRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, textSize.width, textSize.height);
    [_text drawInRect:textRect withFont:_font];
}

@end
