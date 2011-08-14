//
//  RSReport.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSReport.h"
#import "NSFileManager+DirectoryLocations.h"
#import "RSReportHeader.h"

@interface RSReport ()

@end

@implementation RSReport

@synthesize pdfFileName = _pdfFileName;
@synthesize pageSize = _pageSize;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize reportHeader = _reportHeader;

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
        _documentDirectory = [[NSFileManager defaultManager] applicationSupportDirectory];
    }
    
    return self;
}

- (id)initWithFileName:(NSString *)fileName andPageSize:(CGRect) size {
    self = [super init];
    if (self) {
        _pdfFileName = fileName;
        _pageSize = size;
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
    NSString *nomeFile = [_documentDirectory stringByAppendingPathComponent:_pdfFileName];
    // Verifica se il file esiste ed eventualmente lo cancella
    NSError *errore;
    if ([[NSFileManager defaultManager] fileExistsAtPath:nomeFile])
        [[NSFileManager defaultManager] removeItemAtPath:nomeFile error:&errore];
    // Quindi crea il file contenente il PDF destinatario
    if(!UIGraphicsBeginPDFContextToFile(nomeFile, _pageSize, nil))
        return NO;
    
    // Esegue quindi le elaborazioni necessarie
    _currentVPosition = 0;
    _currentPage = 0;
    
    // Avvia la prima pagina
    [self updateCurrentPage];
    
    // Estrae il context del PDF in modo da passarlo a tutte le funzioni richiamate
    _pdfContext = UIGraphicsGetCurrentContext();
    
    // Se l'header del report è settato ne esegue quindi la stampa
    if (_reportHeader) {
        [_reportHeader printHeaderWithContext:_pdfContext];
    }
    
    // Se è settata la sezione del corpo ne esegue la stampa
    
    
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
    UIGraphicsBeginPDFPage();
    ++_currentPage;    
}

@end
