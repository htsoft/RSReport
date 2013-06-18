//
//  RSLineItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSLineItem.h"

@implementation RSLineItem

@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;
@synthesize lineWidth = _lineWidth;

- (id)init
{
    self = [super init];
    if (self) {
        _lineWidth = 1.0;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = _lineWidth;
    CGPoint referencePoint = [self.delegate getReferenceSectionPoint];
    [bp moveToPoint:CGPointMake(_startPoint.x+referencePoint.x, _startPoint.y+referencePoint.y)];
    [bp addLineToPoint:CGPointMake(_endPoint.x+referencePoint.x, _endPoint.y+referencePoint.y)];
    [bp stroke];
}

- (NSString *)addStructureWithLevel:(NSInteger)level insertHeader:(BOOL)insHeader error:(NSError *__autoreleasing *)error
{
    NSString *repStru = @"";
    NSInteger addLevel = 0;
    if (insHeader)
        addLevel = 1;
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@<rslineitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    repStru = [repStru stringByAppendingFormat:@"%@<startpoint>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@\t<x>%f</x>\n",tabLevel,_startPoint.x];
    repStru = [repStru stringByAppendingFormat:@"%@\t<y>%f</y>\n",tabLevel,_startPoint.y];
    repStru = [repStru stringByAppendingFormat:@"%@</startpoint>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@<endpoint>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@\t<x>%f</x>\n",tabLevel,_endPoint.x];
    repStru = [repStru stringByAppendingFormat:@"%@\t<y>%f</y>\n",tabLevel,_endPoint.y];
    repStru = [repStru stringByAppendingFormat:@"%@</endpoint>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@<linewidth>%f</linewidth>\n",tabLevel,_lineWidth];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rslineitem>\n",tabLevel];
    }
    return repStru;
}

@end
