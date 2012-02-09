//
//  RSGenericItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSectionDelegate.h"
#import "RSTypes.h"

@interface RSGenericItem : NSObject

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) id<RSSectionDelegate> delegate;
@property (nonatomic, assign) CGRect absoluteRect;

- (void)printItemInContext:(CGContextRef)context;

@end
