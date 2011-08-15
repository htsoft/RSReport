//
//  RSSection.h
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSReportDelegate.h"

@interface RSSection : NSObject

@property (nonatomic, retain) id<RSReportDelegate> delegate;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, assign) CGRect frame;

- (void)printSectionWithContext:(CGContextRef)context;

@end
