//
//  RSReport.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSReportDelegate.h"
#import "RSDataSource.h"
#import "RSTypes.h"

@class RSReportHeader;
@class RSBodySection;
@class RSPageHeader;
@class RSPageFooter;

@interface RSReport : NSObject <RSReportDelegate> {
    CGContextRef _pdfContext;
    NSString *_documentDirectory;
    NSInteger _currentPage;
    NSInteger _currentVPosition;
}

@property (nonatomic, assign) CGRect pageSize;
@property (nonatomic, strong) id<RSDataSource> dataSource;
@property (nonatomic, strong) RSReportHeader *reportHeader;
@property (nonatomic, strong) RSBodySection *bodySection;
@property (nonatomic, strong) RSPageHeader *pageHeader;
@property (nonatomic, strong) RSPageFooter *pageFooter;
@property (assign) RSReportType reportType;
@property (assign) RSNewLineSeparator newLineSeparator;
@property (nonatomic, strong) NSString *columSeparator;
@property (nonatomic, strong) NSString *stringDelimiter;


- (id)initWithFileName:(NSString *)fileName andPageSize:(CGRect)frame;
- (BOOL)makeReport;
- (NSString *)getFullPathPDFFileName;
- (NSURL *)getPDFURL;
- (NSString *)getFullPathCSVFileName;
- (NSURL *)getCSVURL;
- (BOOL)saveStructureToURL:(NSURL *)destinationURL error:(NSError *__autoreleasing *)error;

@end
