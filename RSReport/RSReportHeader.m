//
//  RSReportHeader.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSReportHeader.h"

@implementation RSReportHeader

@synthesize newPageAfterPrint = _newPageAfterPrint;

- (id)init
{
    self = [super init];
    if (self) {
        _newPageAfterPrint = NO;
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    [super printSectionWithContext:context];
    
    if (_newPageAfterPrint && [self.delegate respondsToSelector:@selector(updateCurrentPage)])
        [self.delegate updateCurrentPage];
}

- (NSString *)addStructureWithLevel:(NSInteger)level error:(NSError *__autoreleasing *)error {
    NSString *repStru = @"";
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    repStru = [repStru stringByAppendingFormat:@"%@<rsreportheader>\n",tabLevel];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+1 error:error]];
    if(!error) {
        NSString *newPage = @"NO";
        if(_newPageAfterPrint)
            newPage = @"YES";
        repStru = [repStru stringByAppendingFormat:@"%@\t<newpageafterprint>%@</newpageafterprint>\n",tabLevel,newPage];
        repStru = [repStru stringByAppendingFormat:@"%@</rsreportheader>\n",tabLevel];
    }
    
    return repStru;
}

@end
