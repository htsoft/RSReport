//
//  RSLookupArray.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSLookupArray.h"

@implementation RSLookupArray

@synthesize lookupArray = _lookupArray;
@synthesize defaultValue = _defaultValue;

- (id)init
{
    self = [super init];
    if (self) {
        _defaultValue = @"";
        _lookupArray = nil;
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *value = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        if(self.lookupArray) {
            NSInteger indice = [(NSNumber *)value integerValue];
            if(indice<0 || indice>=[self.lookupArray count]) {
                self.text = self.defaultValue;
            } else {
                self.text = (NSString *)[self.lookupArray objectAtIndex:indice];
            }
        } else {
            self.text = self.defaultValue;
        }
    } else {
        self.text = self.defaultValue;
    }
    [super printItemInContext:context];
}

- (NSString *)addStructureWithLevel:(NSInteger)level insertHeader:(BOOL)insHeader error:(NSError *__autoreleasing *)error
{
    NSString *repStru = @"";
    NSInteger addLevel = 0;
    if (insHeader)
        addLevel = 1;
    
    NSString *tabLevel = @"";
    for(NSInteger i=0;i<level;i++)
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@<rslookuparray>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if(_defaultValue) {
        repStru = [repStru stringByAppendingFormat:@"%@<defaultvalue>%@</defaultvalue>\n",tabLevel,_defaultValue];
    }
    if(_lookupArray) {
        repStru = [repStru stringByAppendingFormat:@"%@<items>\n",tabLevel];
        for(NSString *item in _lookupArray)
            repStru = [repStru stringByAppendingFormat:@"%@\t<item>%@</item>\n",tabLevel,item];
        repStru = [repStru stringByAppendingFormat:@"%@</items>\n",tabLevel];
    }
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rslookuparray>\n",tabLevel];
    }
    return repStru;
}

@end
