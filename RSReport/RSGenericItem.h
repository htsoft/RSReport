//
//  RSGenericItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSGenericItem : NSObject

@property (nonatomic, assign) CGRect *frame;

- (void)printItemInContext:(CGContextRef)context;

@end
