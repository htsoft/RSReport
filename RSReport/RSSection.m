//
//  RSSection.m
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSSection.h"
#import "RSGenericItem.h"
#import "RSTextItem.h"

@implementation RSSection

@synthesize delegate = _delegate;
@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;
@synthesize frame = _frame;
@synthesize bordersToDraw = _bordersToDraw;
@synthesize borderWidth = _borderWidth;
@synthesize printableItems = _printableItems;
@synthesize dataSource = _dataSource;
@synthesize tag = _tag;

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
        gi.delegate = self;
        [gi printItemInContext:context];
    } 
    
    if ([self.delegate respondsToSelector:@selector(updateVPosition:)]) 
        [self.delegate updateVPosition:self.frame.size.height];
}

- (id<RSDataSource>)getDataSource {
    return [self.delegate getDataSource];
}

- (CGPoint)getReferenceSectionPoint {
    return _frame.origin;
}

- (void)evaluate {
    NSLog(@"Called RSSection evaluate...");
    for (id gi in _printableItems) {
        if ([gi isKindOfClass:[RSTextItem class]]) {
            RSTextItem *si = (RSTextItem *)gi;
            si.delegate = self;
            [si evaluate];
        }
    }
}

- (NSString *)addStructureWithLevel:(NSInteger)level error:(NSError *__autoreleasing *)error {
    CGFloat red,green,blue,alpha;
    NSString *repStru = @"";

    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    repStru = [repStru stringByAppendingFormat:@"%@<frame>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@\t<top>%f</top>\n",tabLevel,_frame.origin.y];
    repStru = [repStru stringByAppendingFormat:@"%@\t<left>%f</left>\n",tabLevel,_frame.origin.x];
    repStru = [repStru stringByAppendingFormat:@"%@\t<width>%f</width>\n",tabLevel,_frame.size.width];
    repStru = [repStru stringByAppendingFormat:@"%@\t<height>%f</height>\n",tabLevel,_frame.size.height];
    repStru = [repStru stringByAppendingFormat:@"%@</frame>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@<borderwidth>%f</borderwidth>\n",tabLevel,_borderWidth];
    [_strokeColor getRed:&red green:&green blue:&blue alpha:&alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<strokecolor>%f;%f;%f;%f</strokecolor>\n",tabLevel,red,green,blue,alpha];
    [_fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<fillcolor>%f;%f;%f;%f</fillcolor>\n",tabLevel,red,green,blue,alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<borderstodraw>%d</borderstodraw>\n",tabLevel,_bordersToDraw];
    repStru = [repStru stringByAppendingFormat:@"%@<tag>%d</tag>\n",tabLevel,_tag];
    if([_printableItems count]>0) {
        // Save items in section
        repStru = [repStru stringByAppendingFormat:@"%@<printableitems>\n",tabLevel];
        for(RSGenericItem *gi in _printableItems) {
            repStru = [repStru stringByAppendingString:[gi addStructureWithLevel:level+1 insertHeader:YES error:error]];
        }
        repStru = [repStru stringByAppendingFormat:@"%@</printableitems>\n",tabLevel];
    }
    
    return repStru;
}

@end
