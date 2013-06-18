//
//  RSRectangleItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSRectangleItem.h"

@implementation RSRectangleItem

@synthesize fillRect = _fillRect;
@synthesize lineWidth = _lineWidth;
@synthesize cornerRadius = _cornerRadius;

- (id)init
{
    self = [super init];
    if (self) {
        _lineWidth = 1.0;
        _cornerRadius = 0;
        _fillRect = NO;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:self.absoluteRect cornerRadius:_cornerRadius];
    bp.lineWidth = _lineWidth;
    [bp stroke];
    if (_fillRect) {
        [bp fill];
    }
}

- (NSString *)addStructureWithLevel:(NSInteger)level insertHeader:(BOOL)insHeader error:(NSError *__autoreleasing *)error
{
    NSString *repStru = @"";
    NSString *fRect = @"NO";
    if (_fillRect)
        fRect = @"YES";
    NSInteger addLevel = 0;
    if (insHeader)
        addLevel = 1;
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@<rsrectangleitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    repStru = [repStru stringByAppendingFormat:@"%@\t<linewidth>%f</linewidth>\n",tabLevel,_lineWidth];
    repStru = [repStru stringByAppendingFormat:@"%@\t<cornerradius>%f</cornerradius>\n",tabLevel,_cornerRadius];
    repStru = [repStru stringByAppendingFormat:@"%@\t<fillrect>%@</fillrect>\n",tabLevel,fRect];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rsrectangleitem>\n",tabLevel];
    }
    return repStru;
}

@end
