//
//  RSTextItem.m
//  RSReport
//
//  Created by Roberto Scarciello on 14/08/11.
//  Copyright 2011 Roberto Scarciello. All rights reserved.
//

#import "RSTextItem.h"

@implementation RSTextItem

@synthesize text = _text;
@synthesize font = _font;
@synthesize itemAlignment = _itemAlignment;

- (id)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

- (void)printItemInContext:(CGContextRef)context {
    [super printItemInContext:context];
    
    if ([_text length]>0) {
        NSString *primoCar = [_text substringToIndex:1];
        if ([primoCar isEqualToString:@"\n"])
            _text = [_text substringFromIndex:1];
    }
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGSize textSize = [_text sizeWithFont:_font constrainedToSize:self.absoluteRect.size lineBreakMode:UILineBreakModeClip];
    // Calcola la posizione per l'allineamento
    CGPoint textPosition = CGPointMake(0, 0);
    switch (_itemAlignment) {
        case RSItemAlignLeft:
            // In caso di allineamento a sinistra non deve compiere alcuna operazione
            textPosition.x = 0;
            break;
        case RSItemAlignCenter:
            textPosition.x = (self.absoluteRect.size.width - textSize.width)/2;
            break;
        case RSItemAlignRight:
            textPosition.x = self.absoluteRect.size.width - textSize.width;
            break;
            
        default:
            // Nel caso non sia assegnato nessun valore valido allinea a sinistra
            textPosition.x = 0;
            break;
    }
    CGRect textRect = CGRectMake(self.absoluteRect.origin.x+textPosition.x, self.absoluteRect.origin.y, textSize.width, textSize.height);
    [_text drawInRect:textRect withFont:_font];
}

- (void)evaluate 
{
    NSLog(@"Called anchestor evaluate...");
}

@end
