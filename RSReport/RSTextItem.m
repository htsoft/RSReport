//
//  RSTextItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@interface RSTextItem ()

@property (nonatomic, strong) NSString *textToPrint;

@end

@implementation RSTextItem

@synthesize text = _text;
@synthesize font = _font;
@synthesize itemAlignment = _itemAlignment;
@synthesize attribute = _attribute;
@synthesize textToPrint = _textToPrint;

- (id)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:12];
        _attribute = nil;
        _text = nil;
        _itemAlignment = RSItemAlignLeft;
    }
    
    return self;
}

- (NSString *)writeItemToString {
    NSString *stringItem = [super writeItemToString];
    if(!self.text) {
        NSObject *value = [[self.delegate getDataSource] getAttributeByPath:_attribute];
        if(value) {
            if ([value isKindOfClass:[NSString class]]) {
                NSString *testo = (NSString *)value;
                if([testo length]>0) {
                    NSString *primoCar = [testo substringToIndex:1];
                    if([primoCar isEqualToString:@"\n"])
                        testo = [testo substringFromIndex:1];
                }
                self.textToPrint = testo;
            }
            if ([value isKindOfClass:[NSNumber class]]) {
                self.textToPrint = [((NSNumber *)value) stringValue];
            }
        } else {
            self.textToPrint = nil;
        }
    } else {
        self.textToPrint = [NSString stringWithString:self.text];
    }
    stringItem = [NSString stringWithFormat:@"%@;%@",stringItem,self.textToPrint];
    return stringItem;
}

- (void)printItemInContext:(CGContextRef)context {
    if(!self.text) {
        NSObject *value = [[self.delegate getDataSource] getAttributeByPath:_attribute];
        if(value) {
            if ([value isKindOfClass:[NSString class]]) {
                NSString *testo = (NSString *)value;
                if([testo length]>0) {
                    NSString *primoCar = [testo substringToIndex:1];
                    if([primoCar isEqualToString:@"\n"])
                        testo = [testo substringFromIndex:1];
                }
                self.textToPrint = testo;
            }
            if ([value isKindOfClass:[NSNumber class]]) {
                self.textToPrint = [((NSNumber *)value) stringValue];
            }
        } else {
            self.textToPrint = nil;
        }
    } else {
        self.textToPrint = [NSString stringWithString:self.text];
    }
    
    [super printItemInContext:context];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:_font forKey:NSFontAttributeName];
    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    pStyle.lineBreakMode = NSLineBreakByWordWrapping;
    switch (_itemAlignment) {
        case RSItemAlignLeft:
            pStyle.alignment = NSTextAlignmentLeft;
            break;
        case RSItemAlignCenter:
            pStyle.alignment = NSTextAlignmentCenter;
            break;
        case RSItemAlignRight:
            pStyle.alignment = NSTextAlignmentRight;
            break;
        default:
            pStyle.alignment = NSTextAlignmentNatural;
            break;
    }
    [attributes setValue:pStyle forKey:NSParagraphStyleAttributeName];
    CGRect textRect = self.frame;
    textRect.origin.y = self.absoluteRect.origin.y;
    //[_textToPrint drawInRect:textRect withFont:_font lineBreakMode:NSLineBreakByWordWrapping];
    [_textToPrint drawInRect:textRect withAttributes:attributes];
}

- (void)evaluate 
{
    //NSLog(@"Called anchestor evaluate...");
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
        repStru = [repStru stringByAppendingFormat:@"%@<rstextitem>\n",tabLevel];
        tabLevel = [tabLevel stringByAppendingString:@"\t"];
    }
    if(_text) {
        repStru = [repStru stringByAppendingFormat:@"%@<text>%@</text>\n",tabLevel,_text];
    }
    if(_attribute) {
        repStru = [repStru stringByAppendingFormat:@"%@<attribute>%@</attribute>\n",tabLevel,_attribute];
    }
    repStru = [repStru stringByAppendingFormat:@"%@<font>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@\t<name>%@</name>\n",tabLevel,[_font fontName]];
    repStru = [repStru stringByAppendingFormat:@"%@\t<size>%f</size>\n",tabLevel,[_font pointSize]];
    repStru = [repStru stringByAppendingFormat:@"%@</font>\n",tabLevel];
    repStru = [repStru stringByAppendingFormat:@"%@<itemalignment>%d</itemalignment>\n",tabLevel,_itemAlignment];
    repStru = [repStru stringByAppendingString:[super addStructureWithLevel:level+addLevel insertHeader:NO error:error]];
    if(insHeader) {
        repStru = [repStru stringByAppendingFormat:@"%@</rstextitem>\n",tabLevel];
    }
    return repStru;
}

@end
