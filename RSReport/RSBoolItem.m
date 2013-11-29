//
//  RSBoolItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSBoolItem.h"

@implementation RSBoolItem

@synthesize value = _value;

- (NSString *)writeItemToString {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else
        currentValue = self.value;
    if ([currentValue isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)currentValue) boolValue]) {
            self.text = @"ON";
        } else {
            self.text = @"OFF";
        }
    }
    return [super writeItemToString];
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else
        currentValue = self.value;
    if ([currentValue isKindOfClass:[NSNumber class]]) {
        if ([((NSNumber *)currentValue) boolValue]) {
            self.text = @"ON";
        } else {
            self.text = @"OFF";
        }
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
        repStru = [repStru stringByAppendingFormat:@"%@<rsboolitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if(_value) {
        NSString *valueStr = @"NO";
        if([_value boolValue])
            valueStr = @"YES";
        repStru = [repStru stringByAppendingFormat:@"%@\t<value>%@</value>\n",tabLevel,valueStr];
    }
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rsboolitem>\n",tabLevel];
    }
    return repStru;
}


@end
