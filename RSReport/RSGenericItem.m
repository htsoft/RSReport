//
//  RSGenericItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSGenericItem.h"

@implementation RSGenericItem

@synthesize frame = _frame;
@synthesize strokeColor = _strokeColor;
@synthesize fillColor = _fillColor;
@synthesize delegate = _delegate;
@synthesize absoluteRect = _absoluteRect;
@synthesize tag = _tag;

- (id)init
{
    self = [super init];
    if (self) {
        _strokeColor = [UIColor blackColor];
        _fillColor = [UIColor blackColor];
        _tag = 0;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [_strokeColor setStroke];
    [_fillColor setFill];
    CGPoint referencePoint = [_delegate getReferenceSectionPoint];
    _absoluteRect = CGRectMake(_frame.origin.x + referencePoint.x, _frame.origin.y + referencePoint.y, _frame.size.width, _frame.size.height);
}

- (NSString *)addStructureWithLevel:(NSInteger)level insertHeader:(BOOL)insHeader error:(NSError *__autoreleasing *)error
{
    // parameter insHeader is ignored into RSGenericItem class because GenericItem couldn't be used directly into a report
    NSString *repStru = @"";
    CGFloat red,green,blue,alpha;
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    repStru = [repStru stringByAppendingFormat:@"%@<frame>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@\t<top>%f</top>\n",tabLevel,_frame.origin.y];
    repStru = [repStru stringByAppendingFormat:@"%@\t<left>%f</left>\n",tabLevel,_frame.origin.x];
    repStru = [repStru stringByAppendingFormat:@"%@\t<width>%f</width>\n",tabLevel,_frame.size.width];
    repStru = [repStru stringByAppendingFormat:@"%@\t<height>%f</height>\n",tabLevel,_frame.size.height];
    repStru = [repStru stringByAppendingFormat:@"%@</frame>\n",tabLevel];
    [_strokeColor getRed:&red green:&green blue:&blue alpha:&alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<strokecolor>%f;%f;%f;%f</strokecolor>\n",tabLevel,red,green,blue,alpha];
    [_fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<fillcolor>%f;%f;%f;%f</fillcolor>\n",tabLevel,red,green,blue,alpha];
    repStru = [repStru stringByAppendingFormat:@"%@<tag>%d</tag>\n",tabLevel,_tag];
    
    return repStru;
}

@end
