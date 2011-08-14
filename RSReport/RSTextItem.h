//
//  RSTextItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSGenericItem.h"

@interface RSTextItem : RSGenericItem

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;

@end
