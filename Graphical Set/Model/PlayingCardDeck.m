//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Martin on 20/02/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(id)init{
    
    self = [super init];
    if (self) {
        [self deal];
    }
    return self;
}

-(void)deal
{
    for (NSString *suit in [PlayingCard validSuits]) {
        for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.rank = rank;
            card.suit = suit;
            [self addCard:card atTop:YES];
        }
    }
}

@end
