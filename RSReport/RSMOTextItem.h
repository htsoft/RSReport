//
//  RSMOTextItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"
#import "RSSectionDelegate.h"

@interface RSMOTextItem : RSTextItem

@property (nonatomic, retain) id<RSSectionDelegate> delegate;
@property (nonatomic, retain) NSString *attribute;

@end
