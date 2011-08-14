//
//  RSReportHeader.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSReportDelegate.h"

@interface RSReportHeader : NSObject

@property (nonatomic, retain) id<RSReportDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *printableItems;
@property (nonatomic, assign) CGRect frame;
@property (assign) BOOL newPageAfterPrint;

- (void)printHeaderWithContext:(CGContextRef)context;

@end
