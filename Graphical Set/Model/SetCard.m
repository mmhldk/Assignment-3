//
//  SetCard.m
//  CardGame
//
//  Created by Martin on 14/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards{
    int score = 0;
    if ([otherCards count] == 2) {
        SetCard *cardOne = otherCards[0];
        SetCard *cardTwo = otherCards[1];
        
        
        if (self.number != cardOne.number && self.number != cardTwo.number && cardTwo.number != cardOne.number) {
            score++;
        }
        if (self.number == cardOne.number && self.number == cardTwo.number && cardTwo.number == cardOne.number) {
            score++;
        }
        if ([self.shading isEqualToString:cardOne.shading] && [self.shading isEqualToString:cardTwo.shading] && [cardTwo.shading isEqualToString:cardOne.shading]) {
            score++;
        }
        if (![self.shading isEqualToString:cardOne.shading] && ![self.shading isEqualToString:cardTwo.shading] && ![cardTwo.shading isEqualToString:cardOne.shading]) {
            score++;
        }
        if ([self.color isEqualToArray:cardOne.color] && [self.color isEqualToArray:cardTwo.color] && [cardTwo.color isEqualToArray:cardOne.color]) {
            score++;
        }
        if (![self.color isEqualToArray:cardOne.color] && ![self.color isEqualToArray:cardTwo.color] && ![cardTwo.color isEqualToArray:cardOne.color]) {
            score++;
        }
        if ([self.symbol isEqualToString:cardOne.symbol] && [self.symbol isEqualToString:cardTwo.symbol] && [cardTwo.symbol isEqualToString:cardOne.symbol]) {
            score++;
        }
        if (![self.symbol isEqualToString:cardOne.symbol] && ![self.symbol isEqualToString:cardTwo.symbol] && ![cardTwo.symbol isEqualToString:cardOne.symbol]) {
            score++;
        }
        return score;
    }

    return -1;
}

+(NSArray*)validNumbers{
    return @[@1,@2,@3];
}

+(NSArray*)validColors{
    return @[@[@255.0,@0.0,@0.0],@[@0.0,@255.0,@0.0],@[@255.0,@0.0,@255.0]];
}

+(NSArray*)validShadings{
    return @[@"open",@"striped",@"solid"];
}

+(NSArray*)validSymbols{
    return @[@"diamond",@"oval",@"squiggle"];
}

@end
