//
//  RSPageHeader.m
//  RSReport
//
//  Created by Roberto Scarciello on 19/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSPageHeader.h"

@implementation RSPageHeader

@synthesize printOnFirstPage = _printOnFirstPage;

- (id)init
{
    self = [super init];
    if (self) {
        _printOnFirstPage = NO;
    }
    
    return self;
}

- (void)printSectionWithContext:(CGContextRef)context {
    if ([self.delegate getCurrentPageNumber]>0 || _printOnFirstPage) {
        CGRect originalFrame = self.frame;
        // The Page Header is always positioned at the top left corner
        self.frame = CGRectMake(0, 0, originalFrame.size.width, originalFrame.size.height);
        [super printSectionWithContext:context];
        // Back to the original position
        self.frame = originalFrame;
    }
}

- (NSString *)addStructureWithLevel:(NSInteger)level error:(NSError *__autoreleasing *)error {
    NSString *repStru = @"";
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    repStru = [repStru stringByAppendingFormat:@"%@<rspageheader>\n",tabLevel];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+1 error:error]];
    if(!error) {
        NSString *newPage = @"NO";
        if(_printOnFirstPage)
            newPage = @"YES";
        repStru = [repStru stringByAppendingFormat:@"%@\t<printonfirstpage>%@</printonfirstpage>\n",tabLevel,newPage];
        repStru = [repStru stringByAppendingFormat:@"%@</rspageheader>\n",tabLevel];
    }
    
    return repStru;
}

@end
