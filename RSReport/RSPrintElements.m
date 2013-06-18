//
//  RSPrintElements.m
//  RSReport
//
//  Created by Roberto Scarciello on 24/05/13.
//  Copyright (c) 2013 Roberto Scarciello. All rights reserved.
//

#import "RSPrintElements.h"
#import "RSGenericItem.h"

@implementation RSPrintElements

- (id)elementWithTag:(NSInteger)tag
{
    id foundElement = nil;
    for(id cEl in self)
    {
        RSGenericItem *gi = (RSGenericItem *)cEl;
        if(gi.tag == tag) {
            foundElement = cEl;
            break;
        }
    }
    return foundElement;
}

@end
