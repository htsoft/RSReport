//
//  RSCurrencyItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSCurrencyItem.h"

@implementation RSCurrencyItem

@synthesize locale = _locale;
@synthesize value = _value;
@synthesize numDec = _numDec;

- (void)printItemInContext:(CGContextRef)context {
    NSObject *currentValue = nil;
    if(!self.locale)
        self.locale = [NSLocale currentLocale];
    if (!self.value && self.attribute) 
        currentValue = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    else 
        currentValue = self.value;
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setLocale:self.locale];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
    if(_numDec>0)
        [numFmt setMinimumFractionDigits:_numDec];
    if ([currentValue isKindOfClass:[NSNumber class]]) {
        self.text = [numFmt stringFromNumber:(NSNumber *)currentValue];
    } else {
        self.text = @"";
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
        repStru = [repStru stringByAppendingFormat:@"%@<rscurrencyitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if(_locale)
        repStru = [repStru stringByAppendingFormat:@"%@\t<locale>%@</locale>\n",tabLevel,[_locale localeIdentifier]];
    if(_value)
        repStru = [repStru stringByAppendingFormat:@"%@\t<value>%@</value>\n",tabLevel,[_value stringValue]];
    repStru = [repStru stringByAppendingFormat:@"%@\t<numdec>%d</numdec>\n",tabLevel,_numDec];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rscurrencyitem>\n",tabLevel];
    }
    return repStru;
}

@end
