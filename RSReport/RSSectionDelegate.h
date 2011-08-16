//
//  RSSectionDelegate.h
//  RSReport
//
//  Created by Roberto Scarciello on 16/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSSectionDelegate <NSObject>

@optional

- (NSManagedObject *)getManagedObject;
- (CGPoint)getReferenceSectionPoint;

@end
