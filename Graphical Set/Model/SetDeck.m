//
//  SetDeck.m
//  CardGame
//
//  Created by Martin on 14/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

-(id)init{
    
    self = [super init];
    if (self) {
        [self deal];
    }
    return self;
}

-(void)deal{
    for (NSString *shading in [SetCard validShadings]) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSArray *color in [SetCard validColors]) {
                for (NSNumber *number in [SetCard validNumbers]) {
                    
                    SetCard *card = [[SetCard alloc]init];
                    card.number = number;
                    card.color = color;
                    card.symbol = symbol;
                    card.shading = shading;
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
}

@end
