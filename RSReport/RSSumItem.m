//
//  RSSumItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 22/11/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSSumItem.h"

@interface RSSumItem ()

@property (nonatomic, strong) NSNumber *currentSum;

@end

@implementation RSSumItem

@synthesize isCurrency = _isCurrency;
@synthesize currentSum = _currentSum;
@synthesize locale = _locale;

- (id)init
{
    self = [super init];
    if (self) {
        _isCurrency = NO;
        _currentSum = [NSNumber numberWithDouble:0];
        _locale = nil;
    }
    
    return self;
}

- (void)evaluate {
    NSObject *value = [[self.delegate getDataSource] getAttributeByPath:self.attribute];
    if ([value isKindOfClass:[NSNumber class]]) {
        NSLog(@"Called evaluate...");
        double sum = [_currentSum doubleValue] + [((NSNumber *)value) doubleValue];
        _currentSum = [NSNumber numberWithDouble:sum];
    }
}

- (void)printItemInContext:(CGContextRef)context {
    if (_isCurrency) {
        if(!self.locale)
            self.locale = [NSLocale currentLocale];
        NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
        [numFmt setLocale:self.locale];
        [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.text = [numFmt stringFromNumber:_currentSum];
    } else {
        self.text = [_currentSum stringValue];
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
        repStru = [repStru stringByAppendingFormat:@"%@<rssumitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    NSString *isCurrencyStr = @"NO";
    if(_isCurrency)
        isCurrencyStr = @"YES";
    if(_locale)
        repStru = [repStru stringByAppendingFormat:@"%@\t<locale>%@</locale>\n",tabLevel,[_locale localeIdentifier]];
    repStru = [repStru stringByAppendingFormat:@"%@\t<iscurrency>%@</iscurrency>\n",tabLevel,isCurrencyStr];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rssumitem>\n",tabLevel];
    }
    return repStru;
}

@end
