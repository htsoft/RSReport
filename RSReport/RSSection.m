//
//  RSSection.m
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSSection.h"
#import "RSGenericItem.h"

@implementation RSSection

@synthesize delegate = _delegate;
@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;
@synthesize frame = _frame;
@synthesize bordersToDraw = _bordersToDraw;
@synthesize borderWidth = _borderWidth;
@synthesize managedObject = _managedObject;
@synthesize printableItems = _printableItems;

- (id)init
{
    self = [super init];
    if (self) {
        _fillColor = [UIColor whiteColor];
        _strokeColor = [UIColor blackColor];
        _borderWidth = 1.0;
        _printableItems = [NSMutableArray array];
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    // Draw the top border
    if (_bordersToDraw & RSTopBorder) {
        UIBezierPath *bp = [UIBezierPath bezierPath];
        bp.lineWidth = _borderWidth;
        [bp moveToPoint:_frame.origin];
        [bp addLineToPoint:CGPointMake(_frame.origin.x+_frame.size.width, _frame.origin.y)];
        [bp stroke];        
    }

    // Draw the left border
    if (_bordersToDraw & RSLeftBorder) {
        UIBezierPath *bp = [UIBezierPath bezierPath];
        bp.lineWidth = _borderWidth;
        [bp moveToPoint:_frame.origin];
        [bp addLineToPoint:CGPointMake(_frame.origin.x, _frame.origin.y+_frame.size.height)];
        [bp stroke];        
    }

    // Draw the right border
    if (_bordersToDraw & RSRightBorder) {
        UIBezierPath *bp = [UIBezierPath bezierPath];
        bp.lineWidth = _borderWidth;
        [bp moveToPoint:CGPointMake(_frame.origin.x+_frame.size.width, _frame.origin.y)];
        [bp addLineToPoint:CGPointMake(_frame.origin.x+_frame.size.width, _frame.origin.y+_frame.size.height)];
        [bp stroke];        
    }

    // Draw the bottom border
    if (_bordersToDraw & RSBottomBorder) {
        UIBezierPath *bp = [UIBezierPath bezierPath];
        bp.lineWidth = _borderWidth;
        [bp moveToPoint:CGPointMake(_frame.origin.x, _frame.origin.y+_frame.size.height)];
        [bp addLineToPoint:CGPointMake(_frame.origin.x+_frame.size.width, _frame.origin.y+_frame.size.height)];
        [bp stroke];        
    }

    // Draw the items into the section
    for (RSGenericItem *gi in _printableItems) {
        [gi printItemInContext:context];
    } 
    
    if ([self.delegate respondsToSelector:@selector(updateVPosition:)]) 
        [self.delegate updateVPosition:self.frame.size.height];
}

- (NSManagedObject *)getManagedObject {
    return _managedObject;
}

@end
