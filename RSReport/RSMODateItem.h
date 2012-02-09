//
//  RSMODateItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 09/02/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSMODateItem : RSTextItem

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *dateFormat;

@end
