//
//  RSBodySection.m
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSBodySection.h"
#import "RSGenericItem.h"

@implementation RSBodySection

@synthesize easyReading = _easyReading;
@synthesize easyReadingColor = _easyReadingColor;

- (id)init
{
    self = [super init];
    if (self) {
        self.easyReading = NO;
        self.easyReadingColor = [UIColor lightGrayColor];
        _currentRow = 0;
    }
    
    return self;
}

- (NSString *)writeSectionToString {
    NSString *sectionString = @"";
    // Prepare CSV headers
    // Draw the items into the section
    for (RSGenericItem *gi in self.printableItems) {
        sectionString = [NSString stringWithFormat:@"%@;%@",sectionString,gi.columnName];
    }
    sectionString = [sectionString stringByAppendingString:@"\n"];
    
    // Main cycle into data
    id<RSDataSource> dataSource = [self.delegate getDataSource];
    BOOL success = [dataSource openStream];
    if (success) {
        NSInteger sections = [dataSource numberOfSections];
        for(NSInteger currentSection=0;currentSection<sections;currentSection++) {
            BOOL rowAvailable = [dataSource firstItemInSection:currentSection];
            while(rowAvailable) {
                sectionString = [sectionString stringByAppendingString:[super writeSectionToString]];
                [self.delegate evaluate:dataSource];
                rowAvailable = [dataSource hasNextInSection:currentSection];
            }
        }
    }
    return sectionString;
}

- (void)printSectionWithContext:(CGContextRef)context {
    // Save the original frame
    CGRect originalFrame = self.frame;
    id<RSDataSource> dataSource = [self.delegate getDataSource];
    BOOL success = [dataSource openStream];
    if (success) {
        NSInteger sections = [dataSource numberOfSections];
        for(NSInteger currentSection=0;currentSection<sections;currentSection++) {
            BOOL rowAvailable = [dataSource firstItemInSection:currentSection];
            while(rowAvailable) {
                // Check for frame position and eventually update it, drawing PageHeader and PageFooter
                if (![self.delegate checkforFrame:self.frame]) {
                    [self.delegate updateCurrentPage];
                    self.frame = originalFrame;
                    self.frame = CGRectMake(originalFrame.origin.x, [self.delegate getCurrentVPosition], originalFrame.size.width, originalFrame.size.height);
                }
                [self evaluate];
                ++_currentRow;
                if((_currentRow % 2 == 0) && self.easyReading) {
                    [self.easyReadingColor setFill];
                    UIBezierPath *bp = [UIBezierPath bezierPathWithRect:self.frame];
                    [bp fill];
                } else {
                    [self.fillColor setFill];
                }
                [super printSectionWithContext:context];
                [self.delegate evaluate:dataSource];
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
                rowAvailable = [dataSource hasNextInSection:currentSection];
            }
        }
    }
}

- (NSString *)addStructureWithLevel:(NSInteger)level error:(NSError *__autoreleasing *)error {
    NSString *repStru = @"";
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    repStru = [repStru stringByAppendingFormat:@"%@<rsbodysection>\n",tabLevel];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+1 error:error]];
    if(!error) {
        NSString *easyReading = @"NO";
        CGFloat red,green,blue,alpha;
        [_easyReadingColor getRed:&red green:&green blue:&blue alpha:&alpha];
        if(_easyReading)
            easyReading = @"YES";
        repStru = [repStru stringByAppendingFormat:@"%@\t<easyreading>%@</easyreading>\n",tabLevel,easyReading];
        repStru = [repStru stringByAppendingFormat:@"%@\t<easyreadingcolor>%f;%f;%f;%f</easyreadingcolor>\n",tabLevel,red,green,blue,alpha];
        repStru = [repStru stringByAppendingFormat:@"%@</rsbodysection>\n",tabLevel];
    }
    
    return repStru;
}

@end
