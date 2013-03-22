//
//  CardGameViewController.h
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView; //abstract
@property (nonatomic) NSUInteger startingCardCount; //abstract
-(Deck*)createDeck;// abstract
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //abstract
-(NSString *)collectionIdentifier; //abstract
-(CardMatchingGame *)createGame;
-(void)updateUI;
-(void) updateStatus;

@end
