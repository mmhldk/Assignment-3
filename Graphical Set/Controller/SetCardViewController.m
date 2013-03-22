//
//  SetCardViewController.m
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetDeck.h"
#import "SetCardCollectionViewCell.h"
#import "SetCardView.h"
#import "SetCard.h"
#import "SetCardMatchingGame.h"
@interface SetCardViewController ()
@property (strong, nonatomic) IBOutletCollection(SetCardView) NSArray *setCardViewCollection;

@end

@implementation SetCardViewController


-(NSUInteger) startingCardCount{
    
    return 12 ;
}
-(Deck*)createDeck
{
    return [[SetDeck alloc] init];
}
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if([card isKindOfClass:[SetCard class]]){
            
            SetCard *setCard = (SetCard *)card;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.shading = setCard.shading;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.faceUp;

            //setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

-(void) updateStatus
{
    for (int i = 0; i < [self.setCardViewCollection count]; i++) {
        SetCardView *setCardView = self.setCardViewCollection[i];
        SetCard *setCard = nil;
        if(i < [self.game.selectedCards count]){
            setCard = self.game.selectedCards[i];
        }
        setCardView.number = setCard.number;
        setCardView.symbol = setCard.symbol;
        setCardView.shading = setCard.shading;
        setCardView.color = setCard.color;
        
    }

}
-(NSString *)collectionIdentifier
{
    return @"SetCard";
}
-(CardMatchingGame *)createGame
{
    return [[SetCardMatchingGame alloc]initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
}
- (IBAction)dealThreeNewCards:(id)sender {
    if (![self.game.deck count]) {
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Card game information"
                                                    message:@"There are no more cards in the deck." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [mes show];
    }
    [(SetCardMatchingGame *)self.game addCardsToGame:3];
    [self updateUI];
}


@end
