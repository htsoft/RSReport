//
//  RSReport.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSReportDelegate.h"

@class RSReportHeader;

@interface RSReport : NSObject <RSReportDelegate> {
    CGContextRef _pdfContext;
    NSString *_documentDirectory;
    NSInteger _currentPage;
    NSInteger _currentVPosition;
}

@property (nonatomic, retain) NSString *pdfFileName;
@property (nonatomic, assign) CGRect pageSize;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) RSReportHeader *reportHeader;

- (id)initWithFileName:(NSString *)fileName andPageSize:(CGRect)frame;
- (BOOL)makeReport;
- (NSString *)getFullPathPDFFileName;

@end
