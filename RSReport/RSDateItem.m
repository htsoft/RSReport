//
//  RSDateItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSDateItem.h"

@implementation RSDateItem

@synthesize dateFormat = _dateFormat;
@synthesize value = _value;

- (id)init
{
    self = [super init];
    if (self) {
        _dateFormat = nil;
    }
    
    return self;
}

- (NSString *)writeItemToString {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else
        currentValue = self.value;
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    if (_dateFormat) {
        [dtFormat setDateFormat:_dateFormat];
    } else {
        [dtFormat setLocale:[NSLocale currentLocale]];
        [dtFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    if ([currentValue isKindOfClass:[NSDate class]]) {
        self.text = [dtFormat stringFromDate:(NSDate *)currentValue];
    } else {
        self.text = @"--/--/----";
    }
    return [super writeItemToString];
}

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue;
    if(!self.value)
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else
        currentValue = self.value;
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    if (_dateFormat) {
        [dtFormat setDateFormat:_dateFormat];
    } else {
        [dtFormat setLocale:[NSLocale currentLocale]];
        [dtFormat setDateStyle:NSDateFormatterMediumStyle];
    }
    if ([currentValue isKindOfClass:[NSDate class]]) {
        self.text = [dtFormat stringFromDate:(NSDate *)currentValue];
    } else {
        self.text = @"--/--/----";
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
        repStru = [repStru stringByAppendingFormat:@"%@<rsdateitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if([_dateFormat length]>0)
        repStru = [repStru stringByAppendingFormat:@"%@\t<dateformat>%@</dateformat>\n",tabLevel,_dateFormat];
    if(_value)
        repStru = [repStru stringByAppendingFormat:@"%@\t<value>%f</value>\n",tabLevel,[_value timeIntervalSince1970]];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rsdateitem>\n",tabLevel];
    }
    return repStru;
}

@end
