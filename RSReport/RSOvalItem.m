//
//  RSOvalItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSOvalItem.h"

@implementation RSOvalItem

@synthesize fillRect = _fillRect;
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
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect:self.absoluteRect];
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
        repStru = [repStru stringByAppendingFormat:@"%@<rsovalitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    repStru = [repStru stringByAppendingFormat:@"%@\t<linewidth>%f</linewidth>\n",tabLevel,_lineWidth];
    repStru = [repStru stringByAppendingFormat:@"%@\t<fillrect>%@</fillrect>\n",tabLevel,fRect];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rsovalitem>\n",tabLevel];
    }
    return repStru;
}

@end
