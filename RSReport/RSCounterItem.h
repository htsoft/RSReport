//
//  RSCounterItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 21/03/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSCounterItem : RSTextItem

- (void)setStartValue:(NSInteger)startValue;
- (NSInteger)getCurrentValue;

@end
