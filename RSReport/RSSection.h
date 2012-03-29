//
//  RSSection.h
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSReportDelegate.h"
#import "RSTypes.h"
#import "RSSectionDelegate.h"

@interface RSSection : NSObject <RSSectionDelegate>

@property (nonatomic, strong) id<RSReportDelegate> delegate;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) RSBorder bordersToDraw;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) NSManagedObject *managedObject;
@property (nonatomic, strong) NSMutableArray *printableItems;

- (void)printSectionWithContext:(CGContextRef)context;
- (void)evaluate;

@end
