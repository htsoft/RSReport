//
//  RSMOImageItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 20/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSImageItem.h"

@interface RSMOImageItem : RSImageItem

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) UIImage *defaultImage;

- (id)initWithDefaultImage:(UIImage *)defaultImage;

@end
