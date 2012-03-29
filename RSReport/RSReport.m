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

@end

@implementation RSReport

@synthesize pdfFileName = _pdfFileName;
@synthesize pageSize = _pageSize;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize reportHeader = _reportHeader;
@synthesize bodySection = _bodySection;
@synthesize pageHeader = _pageHeader;
@synthesize pageFooter = _pageFooter;

- (id)init
{
    self = [super init];
    if (self) {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        _pdfFileName = [NSString stringWithFormat:@"%@.pdf",(__bridge NSString *)newUniqueIdString];
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
        _pageSize = CGRectMake(0, 0, 612, 792);
        _documentDirectory = [self applicationSupportDirectory];
    }
    
    return self;
}

- (id)initWithFileName:(NSString *)fileName andPageSize:(CGRect)frame {
    self = [super init];
    if (self) {
        _pdfFileName = fileName;
        _pageSize = frame;
    }
    
    return self;
}

- (BOOL)makeReport {
    // File name definition
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:_pdfFileName];
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

- (NSInteger)getCurrentPageNumber {
    return _currentPage;
}

- (void)setCurrentPageNumber:(NSInteger)pageNumber {
    _currentPage = pageNumber;
}

- (NSManagedObjectContext *)getManagedObjectContext {
    return _managedObjectContext;
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
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:_pdfFileName];
    return fileName;
}

- (NSURL *)getPDFURL {
    NSURL *returnURL = [NSURL fileURLWithPath:[_documentDirectory stringByAppendingPathComponent:_pdfFileName]];
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

- (void)evaluate:(NSManagedObject *)object {
    if (_pageHeader) {
        _pageHeader.managedObject = object;
        [_pageHeader evaluate];
    }
    if (_pageFooter) {
        _pageFooter.managedObject = object;
        [_pageFooter evaluate];
    }
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
