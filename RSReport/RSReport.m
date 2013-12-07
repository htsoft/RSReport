//
//  RSReport.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSReport.h"
#import "RSReportHeader.h"
#import "RSBodySection.h"
#import "RSPageFooter.h"
#import "RSPageHeader.h"

#define RSXVERSION 1

enum
{
	DirectoryLocationErrorNoPathFound,
	DirectoryLocationErrorFileExistsAtLocation
};

NSString * const DirectoryLocationDomain = @"DirectoryLocationDomain";

@interface RSReport ()

- (NSString *)applicationSupportDirectory;
- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent error:(NSError **)errorOut;

- (BOOL)makePDFReport;
- (BOOL)makeCSVReport;

@end

@implementation RSReport

@synthesize fileName = _fileName;
@synthesize pageSize = _pageSize;
@synthesize dataSource = _dataSource;
@synthesize reportHeader = _reportHeader;
@synthesize bodySection = _bodySection;
@synthesize pageHeader = _pageHeader;
@synthesize pageFooter = _pageFooter;
@synthesize reportType = _reportType;
@synthesize newLineSeparator = _newLineSeparator;
@synthesize columSeparator = _columSeparator;
@synthesize stringDelimiter = _stringDelimiter;

- (id)init
{
    self = [super init];
    if (self) {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        _fileName = [NSString stringWithFormat:@"%@",(__bridge NSString *)newUniqueIdString];
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
        _pageSize = CGRectMake(0, 0, 612, 792);
        _documentDirectory = [self applicationSupportDirectory];
        _reportType = RSReportPDFType;
    }
    
    return self;
}

- (id)initWithFileName:(NSString *)fileName andPageSize:(CGRect)frame {
    self = [super init];
    if (self) {
        _fileName = fileName;
        _pageSize = frame;
    }
    
    return self;
}

- (BOOL)makeReport {
    if(self.reportType == RSReportPDFType)
        return [self makePDFReport];
    else
        return [self makeCSVReport];
}

- (BOOL)makePDFReport {
    // File name definition
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",_fileName]];
    // If already exists then delete
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:&error];
    // PDF file creation
    if(!UIGraphicsBeginPDFContextToFile(fileName, _pageSize, nil))
        return NO;
    
    // Begin operations
    _currentPage = 0;
    
    // Obtain current context for PDF file
    _pdfContext = UIGraphicsGetCurrentContext();
    
    // Start first page
    if (_pageHeader)
        _pageHeader.delegate = self;
    if (_pageFooter)
        _pageFooter.delegate = self;
    
    [self updateCurrentPage];
    
    
    // if Report header is assigned the draw it
    if (_reportHeader) {
        _reportHeader.delegate = self;
        [_reportHeader printSectionWithContext:_pdfContext];
    }
    
    //
    
    // If Body is assigned the draw it
    if (_bodySection) {
        _bodySection.delegate = self;
        [_bodySection printSectionWithContext:_pdfContext];
    }
    
    // After printed last page check if necessary to print pageFooter
    if (_pageFooter && _pageFooter.printOnLastPage) {
        [_pageFooter printSectionWithContext:_pdfContext];
    }
    
    // if Report footer is assigned then draw it
    
    
    // Close the context and the file
    UIGraphicsEndPDFContext();
    
    // Return YES to confirm the succeeded operation
    return YES;
}

- (BOOL)makeCSVReport{
    BOOL retValue = YES;
    // File name definition
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv",_fileName]];
    // If already exists then delete
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:&error];
    // If body is assigned then write the informations
    // starting by the headers
    if(_bodySection) {
        _bodySection.delegate = self;
        NSString *bodySectionString =  [_bodySection writeSectionToString];
        // Writes the BodySectionString to disk
        NSError *error;
        [bodySectionString writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if(error) {
            retValue = NO;
            NSLog(@"Error writing file: %@", error.localizedDescription);
        }
    }
    return retValue;
}


- (NSInteger)getCurrentPageNumber {
    return _currentPage;
}

- (void)setCurrentPageNumber:(NSInteger)pageNumber {
    _currentPage = pageNumber;
}

- (id)getDataSource {
    return _dataSource;
}

- (void)updateCurrentPage {
    if (_pageFooter && _currentPage!=0) {
        _pageFooter.delegate = self;
        [_pageFooter printSectionWithContext:_pdfContext];
    }
    _currentVPosition = 0;
    UIGraphicsBeginPDFPage();
    if (_pageHeader) {
        _pageHeader.delegate = self;
        [_pageHeader printSectionWithContext:_pdfContext];
    }
    ++_currentPage;    
}

- (void)updateVPosition:(CGFloat)delta {
    _currentVPosition += delta;
}

- (CGFloat)getCurrentVPosition {
    return _currentVPosition;
}

- (NSString *)getFullPathPDFFileName {
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",_fileName]];
    return fileName;
}

- (NSURL *)getPDFURL {
    NSURL *returnURL = [NSURL fileURLWithPath:[self getFullPathPDFFileName]];
    return returnURL;
}

- (NSString *)getFullPathCSVFileName {
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv",_fileName]];
    return fileName;
}

- (NSURL *)getCSVURL {
    NSURL *returnURL = [NSURL fileURLWithPath:[self getFullPathCSVFileName]];
    return returnURL;
}

- (BOOL)checkforFrame:(CGRect)frame {
    // Check if adding the frame.size.height to _currentVPosition, then adds the pagefooter height and if it's grater than 
    // the size of the page it return NO
    // Otherwise it return YES
    double position = _currentVPosition + frame.size.height;
    if (_pageFooter) {
        position += _pageFooter.frame.size.height;
    }
    return ((position >= _pageSize.size.height) ? NO : YES);
}

- (CGRect)getCurrentPageSize {
    return _pageSize;
}

- (void)evaluate:(id<RSDataSource>)object {
    if (_pageHeader) {
        _pageHeader.dataSource = object;
        [_pageHeader evaluate];
    }
    if (_pageFooter) {
        _pageFooter.dataSource = object;
        [_pageFooter evaluate];
    }
}

- (BOOL)saveStructureToURL:(NSURL *)destinationURL error:(NSError *__autoreleasing *)error {
    if (error) {
        error = nil;
    }
    NSString *repStru = @"<?xml version='1.0' encoding='UTF-8' ?>\n";
    BOOL ret = YES;
    repStru = [repStru stringByAppendingString:@"<rsreport>\n"];
    // Writes the data structure
    repStru = [repStru stringByAppendingFormat:@"\t<version>%d</version>\n",RSXVERSION];
    repStru = [repStru stringByAppendingString:@"\t<pagesize>\n"];
    repStru = [repStru stringByAppendingFormat:@"\t\t<width>%f</width>\n",_pageSize.size.width];
    repStru = [repStru stringByAppendingFormat:@"\t\t<height>%f</height>\n",_pageSize.size.height];
    repStru = [repStru stringByAppendingString:@"\t</pagesize>\n"];
    repStru = [repStru stringByAppendingFormat:@"\t<filename>%@</filename>\n",_fileName];
    if(_reportHeader) {
        // writes the XML section for the Report Header
        repStru = [repStru stringByAppendingString:[_reportHeader addStructureWithLevel:1 error:error]];
    }
    if(_pageHeader) {
        // writes the XML section for the Page Header
        repStru = [repStru stringByAppendingString:[_pageHeader addStructureWithLevel:1 error:error]];
    }
    if(_bodySection) {
        // writes the XML section for the Report Body
        repStru = [repStru stringByAppendingString:[_bodySection addStructureWithLevel:1 error:error]];
    }
    if(_pageFooter) {
        // writes the XML section for the Page Footer
        repStru = [repStru stringByAppendingString:[_pageFooter addStructureWithLevel:1 error:error]];
    }
    // Close the rsreport block
    if (ret) {
        repStru = [repStru stringByAppendingString:@"</rsreport>\n"];
        ret = [repStru writeToURL:destinationURL atomically:YES encoding:NSUTF8StringEncoding error:error];
    }
    NSLog(@"%@",repStru);
    return ret;
}

- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                           inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent
                              error:(NSError **)errorOut
{
	//
	// Search for the path
	//
    NSFileManager *fm = [NSFileManager defaultManager];
    
	NSArray* paths = NSSearchPathForDirectoriesInDomains(
                                                         searchPathDirectory,
                                                         domainMask,
                                                         YES);
	if ([paths count] == 0)
	{
		if (errorOut)
		{
			NSDictionary *userInfo =
            [NSDictionary dictionaryWithObjectsAndKeys:
             NSLocalizedStringFromTable(
                                        @"No path found for directory in domain.",
                                        @"Errors",
                                        nil),
             NSLocalizedDescriptionKey,
             [NSNumber numberWithInteger:searchPathDirectory],
             @"NSSearchPathDirectory",
             [NSNumber numberWithInteger:domainMask],
             @"NSSearchPathDomainMask",
             nil];
			*errorOut =
            [NSError 
             errorWithDomain:DirectoryLocationDomain
             code:DirectoryLocationErrorNoPathFound
             userInfo:userInfo];
		}
		return nil;
	}
	
	//
	// Normally only need the first path returned
	//
	NSString *resolvedPath = [paths objectAtIndex:0];
    
	//
	// Append the extra path component
	//
	if (appendComponent)
	{
		resolvedPath = [resolvedPath
                        stringByAppendingPathComponent:appendComponent];
	}
	
	//
	// Create the path if it doesn't exist
	//
	NSError *error = nil;
	BOOL success = [fm
                    createDirectoryAtPath:resolvedPath
                    withIntermediateDirectories:YES
                    attributes:nil
                    error:&error];
	if (!success) 
	{
		if (errorOut)
		{
			*errorOut = error;
		}
		return nil;
	}
	
	//
	// If we've made it this far, we have a success
	//
	if (errorOut)
	{
		*errorOut = nil;
	}
	return resolvedPath;
}

//
// applicationSupportDirectory
//
// Returns the path to the applicationSupportDirectory (creating it if it doesn't
// exist).
//
- (NSString *)applicationSupportDirectory
{
	NSString *executableName =
    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
	NSError *error;
	NSString *result =
    [self
     findOrCreateDirectory:NSApplicationSupportDirectory
     inDomain:NSUserDomainMask
     appendPathComponent:executableName
     error:&error];
	if (!result)
	{
		NSLog(@"Unable to find or create application support directory:\n%@", error);
	}
	return result;
}

@end
