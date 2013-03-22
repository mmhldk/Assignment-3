//
//  SetCardMatchingGame.m
//  Graphical Set
//
//  Created by Martin on 19/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCard.h"

@implementation SetCardMatchingGame

-(void)usedCardHandler: (Card *)card{
    [self.cards removeObjectIdenticalTo:card];
    if([self.cards count] < 12){
        for (int i = 0; i < 3; i++) {
            [self.cards addObject:[self.deck drawRandomCard]];
        }
    }
}
-(void)addCardsToGame:(NSUInteger)numberOfCards
{
    for (int i = 0; i < numberOfCards; i++) {
        Card *card = [self.deck drawRandomCard];

        if(card){
            [self.cards addObject:card];
        }
    }
}
@end
