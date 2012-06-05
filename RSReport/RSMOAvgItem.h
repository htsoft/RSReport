//
//  RSMOAvgItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 05/06/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSMOAvgItem : RSTextItem

@property (nonatomic, strong) NSString *attribute;
@property (assign) BOOL isCurrency;

@end
