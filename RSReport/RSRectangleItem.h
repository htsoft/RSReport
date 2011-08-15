//
//  RSRectangleItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 15/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSGenericItem.h"

@interface RSRectangleItem : RSGenericItem

@property (nonatomic, assign) BOOL fillRect;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@end
