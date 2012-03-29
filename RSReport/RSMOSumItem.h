//
//  RSMOSumItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 29/03/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSMOSumItem : RSTextItem

@property (nonatomic, strong) NSString *attribute;
@property (assign) BOOL isCurrency;

- (void)evaluate;

@end
