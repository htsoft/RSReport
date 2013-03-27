//
//  RSDictionaryArrayDataSource.h
//  RSReport
//
//  Created by Roberto Scarciello on 26/03/13.
//  Copyright (c) 2013 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDataSource.h"

@interface RSDictionaryArrayDataSource : NSObject<RSDataSource> {
    NSInteger numberOfSections;
    NSInteger currentRowIndex;
    NSDictionary *currentRow;
}

@property (nonatomic, strong) NSArray *sourceArray;

- (id)initWithSource:(NSArray *)source;

@end
