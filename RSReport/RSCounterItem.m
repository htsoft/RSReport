//
//  RSCounterItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 21/03/12.
//  Copyright (c) 2012 Roberto Scarciello. All rights reserved.
//

#import "RSCounterItem.h"

@interface RSCounterItem ()

@property NSInteger counter;

@end

@implementation RSCounterItem

@synthesize counter = _counter;

- (id)init
{
    self = [super init];
    if (self)
    {
        _counter = 0;
    }
    return self;
}

- (void)setStartValue:(NSInteger)startValue 
{
    _counter = startValue-1;
}

- (NSInteger)getCurrentValue 
{
    return  _counter;
}

- (void)printItemInContext:(CGContextRef)context {
    ++_counter;
    self.text = [NSString stringWithFormat:@"%d",_counter];
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
        repStru = [repStru stringByAppendingFormat:@"%@<rscounteritem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rscounteritem>\n",tabLevel];
    }
    return repStru;
}

@end
