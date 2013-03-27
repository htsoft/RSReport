//
//  RSReportDelegate.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDataSource.h"

@protocol RSReportDelegate <NSObject>

- (NSInteger)getCurrentPageNumber;
- (void)setCurrentPageNumber:(NSInteger)pageNumber;
- (id)getDataSource;
- (void)updateCurrentPage;
- (void)updateVPosition:(CGFloat)delta;
- (CGFloat)getCurrentVPosition;
- (BOOL)checkforFrame:(CGRect)frame;
- (CGRect)getCurrentPageSize;
- (void)evaluate:(id<RSDataSource>)object;

@end
