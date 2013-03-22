//
//  SetCard.h
//  CardGame
//
//  Created by Martin on 14/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic)NSNumber *number;
@property (nonatomic)NSString *shading;
@property (strong, nonatomic)NSString *symbol;
@property (strong, nonatomic)NSArray *color;

+(NSArray*)validNumbers;
+(NSArray*)validShadings;
+(NSArray*)validSymbols;
+(NSArray*)validColors;

@end


