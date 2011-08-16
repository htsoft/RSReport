//
//  RSBodySection.h
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSSection.h"
#import "RSReportDelegate.h"

@interface RSBodySection : RSSection

@property (nonatomic, retain) id<RSReportDelegate> delegate;
@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSString *sortKey;

@end
