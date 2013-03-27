//
//  RSDataSource.h
//  RSReport
//
//  Created by Roberto Scarciello on 05/12/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSDataSource <NSObject>

@required

- (BOOL)openStream;
- (void)closeStream;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfObjectsInSection:(NSInteger)section;
- (BOOL)firstItemInSection:(NSInteger)section;
- (BOOL)hasNextInSection:(NSInteger)section;
- (id)getAttributeByPath:(NSString *)name;

@optional


@end
