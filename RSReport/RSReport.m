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

- (id)init
{
    self = [super init];
    if (self) {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
        _pdfFileName = [NSString stringWithFormat:@"%@.pdf",(NSString *)newUniqueIdString];
        CFRelease(newUniqueId);
        CFRelease(newUniqueIdString);
        _pageSize = CGRectZero;
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
    // Struttura della funzione
    // 1 - Verifica dell'esistenza del file ed eventuale cancellazione
    // 2 - Creazione del context del file 
    // 3 - Verifica dell'esistenza di un Header per il Report e sua stampa
    // 4 - Stampa del corpo (che stampa header pagina e footer pagina)
    // 5 - Verifica dell'esistenza di un Footer per il Report e sua stampa
    
    // Definisce il nome del file
    NSString *fileName = [_documentDirectory stringByAppendingPathComponent:_pdfFileName];
    // Verifica se il file esiste ed eventualmente lo cancella
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:&error];
    // Quindi crea il file contenente il PDF destinatario
    if(!UIGraphicsBeginPDFContextToFile(fileName, _pageSize, nil))
        return NO;
    
    // Esegue quindi le elaborazioni necessarie
    _currentPage = 0;
    
    // Avvia la prima pagina
    [self updateCurrentPage];
    
    // Estrae il context del PDF in modo da passarlo a tutte le funzioni richiamate
    _pdfContext = UIGraphicsGetCurrentContext();
    
    // Se l'header del report è settato ne esegue quindi la stampa
    if (_reportHeader) {
        _reportHeader.delegate = self;
        [_reportHeader printSectionWithContext:_pdfContext];
    }
    
    // Se è settata la sezione del corpo ne esegue la stampa
    if (_bodySection) {
        _bodySection.delegate = self;
        [_bodySection printSectionWithContext:_pdfContext];
    }
    
    // Se è settato il footer del report ne esegue la stampa
    
    
    // Chiude il file dopo aver terminato il lavoro
    UIGraphicsEndPDFContext();
    
    // Indica che l'operazione è perfettamente riuscita
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
    _currentVPosition = 0;
    UIGraphicsBeginPDFPage();
    ++_currentPage;    
}

- (void)updateVPosition:(CGFloat)delta {
    _currentVPosition += delta;
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
    return YES;
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
