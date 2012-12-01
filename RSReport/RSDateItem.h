//
//  RSDateItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSDateItem : RSTextItem

@property (nonatomic, strong) NSString *dateFormat;
@property (nonatomic, strong) NSDate *value;

@end
