//
//  RSGenericItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSectionDelegate.h"

@interface RSGenericItem : NSObject {
    CGRect _absoluteRect;
}

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) id<RSSectionDelegate> delegate;

- (void)printItemInContext:(CGContextRef)context;

@end
