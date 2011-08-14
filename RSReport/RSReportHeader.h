//
//  RSReportHeader.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSReportHeader : NSObject

@property (nonatomic, retain) NSMutableArray *printableItems;
@property (nonatomic, assign) CGRect frame;

- (void)printHeaderWithContext:(CGContextRef)context;

@end
