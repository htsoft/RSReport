//
//  RSReportDelegate.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSReportDelegate <NSObject>

@optional

- (NSInteger)getCurrentPageNumber;
- (void)setCurrentPageNumber:(NSInteger)pageNumber;
- (NSManagedObjectContext *)getManagedObjectContext;
- (void)updateCurrentPage;
- (void)updateVPosition:(CGFloat)delta;
- (BOOL)checkforFrame:(CGRect)frame;

@end
