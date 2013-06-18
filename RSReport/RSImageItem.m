//
//  RSImageItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSImageItem.h"
#import "NSData+Base64.h"

@implementation RSImageItem

@synthesize image = _image;
@synthesize attribute = _attribute;
@synthesize defaultImage = _defaultImage;

- (id)init
{
    self = [super init];
    if (self) {
        _image = nil;
        _attribute = nil;
        _defaultImage = nil;
    }
    
    return self;
}

- (id)initWithDefaultImage:(UIImage *)defaultImage forAttribute:(NSString *)attribute
{
    self = [super init];
    if(self) {
        _image = nil;
        _attribute = attribute;
        _defaultImage = defaultImage;
    }
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    if(!self.image) {
        NSString *value = [[self.delegate getDataSource] getAttributeByPath:_attribute];
        self.image = [UIImage imageWithContentsOfFile:value];
        if(!self.image)
            self.image = self.defaultImage;
    }
    if(self.image) {
        [super printItemInContext:context];
        [self.image drawInRect:self.absoluteRect];
    }
}

- (NSString *)addStructureWithLevel:(NSInteger)level insertHeader:(BOOL)insHeader error:(NSError *__autoreleasing *)error
{
    NSString *repStru = @"";
    NSString *image64 = nil;
    NSString *defImg64 = nil;
    NSInteger addLevel = 0;
    if (insHeader)
        addLevel = 1;
    if(_image) {
        image64 = [UIImagePNGRepresentation(_image) base64EncodedString];
    }
    if(_defaultImage) {
        defImg64 = [UIImagePNGRepresentation(_defaultImage) base64EncodedString];
    }
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@<rsimageitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if(_attribute) {
        repStru = [repStru stringByAppendingFormat:@"%@\t<attribute>%@</attribute>\n",tabLevel,_attribute];
    }
    if(_image) {
        repStru = [repStru stringByAppendingFormat:@"%@\t<image>%@</image>\n",tabLevel,image64];
    }
    if(_defaultImage) {
        repStru = [repStru stringByAppendingFormat:@"%@\t<defaultimage>%@</defaultimage>\n",tabLevel,defImg64];
    }
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rsimageitems>\n",tabLevel];
    }
    return repStru;
}


@end
