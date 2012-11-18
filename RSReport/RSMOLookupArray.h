//
//  RSMOLookupArray.h
//  RSReport
//
//  Created by Roberto Scarciello on 18/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSMOLookupArray : RSTextItem

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSArray  *lookupArray;
@property (nonatomic, strong) NSString *defaultValue;

@end
