//
//  RSImageItem.h
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSGenericItem.h"

@interface RSImageItem : RSGenericItem

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) UIImage *defaultImage;

- (id)initWithDefaultImage:(UIImage *)defaultImage forAttribute:(NSString *)attribute;

@end
