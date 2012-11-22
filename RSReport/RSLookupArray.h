//
//  RSLookupArray.h
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSLookupArray : RSTextItem

@property (nonatomic, strong) NSArray  *lookupArray;
@property (nonatomic, strong) NSString *defaultValue;

@end
