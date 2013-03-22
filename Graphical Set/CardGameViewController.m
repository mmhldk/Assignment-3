//
//  CardGameViewController.m
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"


@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) NSUInteger flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation CardGameViewController

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.game.cards count];
}
-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self collectionIdentifier] forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}
-(NSString *)collectionIdentifier
{ 
    //abstract
    return nil;
}
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    //abstract
}

-(Deck*)createDeck{ return nil; }// abstract

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [self createGame];
    }
    return _game;
}

-(CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc]initWithCardCount:self.startingCardCount usingDeck:[self createDeck]];
}
-(void)updateUI{
    [self.cardCollectionView reloadData];
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self. game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.text = self.game.status;
    
}
- (IBAction)dealNew:(UIButton *)sender {
    self.flipCount = 0;
    [self.game reset];
    [self updateUI];
}

-(void)setFlipCount:(NSUInteger)flipCount{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
    
}
- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath){
        self.flipCount++;
        [self.game flipCardAtIndex:indexPath.item];
        [self updateStatus];
        [self updateUI];
    }
}
-(void) updateStatus
{
    //absctract
}


@end
