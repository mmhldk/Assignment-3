//
//  PlayingCardGameViewController.m
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *PlayingCardViewCollection;

@end

@implementation PlayingCardGameViewController

-(NSUInteger) startingCardCount{
    return 22;
}
-(Deck*)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if([card isKindOfClass:[PlayingCard class]]){
            
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.faceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
            
        }
    }
}
-(NSString *)collectionIdentifier
{
    return @"PlayingCard";
}

-(void) updateStatus
{
    for (int i = 0; i < [self.PlayingCardViewCollection count]; i++) {
        PlayingCardView *playingCardView = self.PlayingCardViewCollection[i];
        PlayingCard *playingCard = nil;
        if(i < [self.game.selectedCards count]){
            playingCard = self.game.selectedCards[i];
        }
        playingCardView.suit = playingCard.suit;
        playingCardView.rank = playingCard.rank;
        
        
    }
    
}

@end
