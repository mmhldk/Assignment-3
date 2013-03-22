//
//  PlayingCardView.h
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong,nonatomic)NSString *suit;

@property(nonatomic) BOOL faceUp;
@end
