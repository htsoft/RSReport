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


@end
