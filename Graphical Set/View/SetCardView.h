//
//  SetCardView.h
//  Graphical Set
//
//  Created by Martin on 18/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic)NSNumber *number;
@property (nonatomic)NSString *shading;
@property (strong, nonatomic)NSString *symbol;
@property (strong, nonatomic)NSArray *color;

@property (nonatomic)BOOL faceUp;

@end
