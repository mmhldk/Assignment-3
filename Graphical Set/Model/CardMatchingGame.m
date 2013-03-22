//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Martin on 20/02/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property(readwrite, nonatomic)int score;
@property(nonatomic)NSUInteger numberOfCards;
@property(nonatomic)BOOL okayToClearSelectedCards;
@end
@implementation CardMatchingGame


-(NSMutableArray *)cards
{
    if(!_cards){
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(NSMutableArray *)selectedCards
{
    if(!_selectedCards){
        _selectedCards = [[NSMutableArray alloc]init];
    }
    return _selectedCards;
}

-(void)flipCardAtIndex:(NSUInteger)index{
    if (self.okayToClearSelectedCards) {
        self.okayToClearSelectedCards = !self.okayToClearSelectedCards;
        [self.selectedCards removeAllObjects];
    }
    Card *card = [self cardAtIndex:index];

    if(card && !card.isUnplayable){
        NSMutableArray *scoreCoutingCards = [[NSMutableArray alloc] initWithObjects:nil];
        
        if(!card.isFaceUp){
            self.status = [NSString stringWithFormat:@"Flipped - Cost -1 point"];
            [self.selectedCards addObject:card];

            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    [scoreCoutingCards addObject:otherCard];
                }
            }
            
            
            int matchScore = [card match:scoreCoutingCards];
            
            card.faceUp = !card.isFaceUp;
            self.score -= 1;
            
            
            if(matchScore > 0){
                for (Card *scoreCard in scoreCoutingCards) {
                    [self.selectedCards addObject:scoreCard];
                    [self usedCardHandler:scoreCard];
                }
                [self.selectedCards addObject:card];
                [self usedCardHandler:card];
                //card.unplayable = YES;
                self.score += matchScore * 4;
                self.status = [NSString stringWithFormat:@"Mached - Point %d", matchScore * 4];
                self.okayToClearSelectedCards = YES;
                card.faceUp = NO;
            }else if(matchScore == 0){
                for (Card *scoreCard in scoreCoutingCards) {
                    [self.selectedCards addObject:scoreCard];
                    scoreCard.faceUp = NO;
                }
                card.faceUp = NO;
                self.score -= 2;
                self.status = [NSString stringWithFormat:@"Don't match - Penalty %d points", -2];
                self.okayToClearSelectedCards = YES;
            }
            
        }else{
            [self.selectedCards removeAllObjects];
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    otherCard.faceUp = NO;
                }
            }
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
-(void)usedCardHandler: (Card *)card{
    //abstract
}

-(void)reset{
    [self.cards removeAllObjects];
    [self.selectedCards removeAllObjects];
    self.started = !self.isStarted;
    self.status = @"New game";
    self.score = 0;
    [self dealCard];
    
}

-(void)dealCard{
    [self.deck deal];
    for (int i = 0; i < self.numberOfCards; i++){
        Card *card = [self.deck drawRandomCard];
        if(card) {
            self.cards[i] = card;
        }else{
            break;
        }
    }
}
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    self.numberOfCards = count;
    self.deck = deck;
    
    if(self){
        [self dealCard];
    }
    return self;
}
@end
