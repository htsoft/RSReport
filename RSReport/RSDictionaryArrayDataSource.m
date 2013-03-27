//
//  RSDictionaryArrayDataSource.m
//  RSReport
//
//  Created by Roberto Scarciello on 26/03/13.
//  Copyright (c) 2013 Roberto Scarciello. All rights reserved.
//

#import "RSDictionaryArrayDataSource.h"

@implementation RSDictionaryArrayDataSource

@synthesize sourceArray = _sourceArray;

- (id)initWithSource:(NSArray *)source {
    self = [super init];
    if(self) {
        self.sourceArray = source;
    }
    return self;
}

- (BOOL)openStream
{
    // Basically for this class this function does nothing
    // It only sets the number of sections to 1 and the current row to 0
    numberOfSections = 1;
    currentRowIndex = 0;
    currentRow = nil;
    if(self.sourceArray)
        return YES;
    else
        return NO;
}

- (void)closeStream
{
    // For this class this function does nothing
}

- (NSInteger)numberOfSections
{
    // Actually only monodimensional array are supported
    return numberOfSections;
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)section
{
    return [self.sourceArray count];
}

- (BOOL)firstItemInSection:(NSInteger)section
{
    currentRowIndex = 0;
    if([self.sourceArray count]>0) {
        currentRow = (NSDictionary *)[self.sourceArray objectAtIndex:currentRowIndex];
        return YES;
    } else {
        currentRow = nil;
        return NO;
    }
}

- (BOOL)hasNextInSection:(NSInteger)section
{
    ++currentRowIndex;
    if(currentRowIndex<[self.sourceArray count]) {
        currentRow = (NSDictionary *)[self.sourceArray objectAtIndex:currentRowIndex];
        return YES;
    } else {
        currentRow = nil;
        return NO;
    }
}

- (id)getAttributeByPath:(NSString *)name
{
    if(currentRow) {
        return [currentRow valueForKey:name];
    } else {
        return nil;
    }
}

@end
