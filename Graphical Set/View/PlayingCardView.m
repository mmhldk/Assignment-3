//
//  PlayingCardView.m
//  Graphical Set
//
//  Created by Martin on 17/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#define COURNER_RADIUS 12.0

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:COURNER_RADIUS];
     
     [roundedRect addClip];
     
     [[UIColor whiteColor] setFill];
     UIRectFill(self.bounds);
     
     [[UIColor blackColor]setStroke];
    [roundedRect stroke];
    
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.jpg", [self rankAsString], self.suit]];
        if(faceImage)
        {
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width, self.bounds.size.height);
            [faceImage drawInRect:imageRect];
        }else{
            [self drawPips];
        }
        
        [self drawCorners];
    }else{
        [[UIImage imageNamed:@"cardback.jpg"] drawInRect:self.bounds];
    }
    
    
}


#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270
#define PIP_FONT_SCALE_FACTOR 0.20 
-(void)drawPips
{
    if ((self.rank == 1) || (self.rank == 5)  || (self.rank == 9)  || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if((self.rank == 6)  || (self.rank == 7)  || (self.rank == 8)){
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if((self.rank == 2)  || (self.rank == 3) || (self.rank == 7)  || (self.rank == 8) || (self.rank == 10)){
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    if ((self.rank == 4)  || (self.rank == 5)  || (self.rank == 6)  || (self.rank == 7)  || (self.rank == 8)  || (self.rank == 9)  || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}
-(void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                     verticalOffset:(CGFloat)voffset
                         upsideDown:(BOOL)upsideDown
{
    if (upsideDown) {
        [self pushContextAndRotateUpSideDown];
    }
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width* PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName:pipFont}];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(
                                    middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height);
    [attributedSuit drawAtPoint:pipOrigin];
    if (upsideDown) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if(upsideDown) [self popContext];
}

-(void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                     verticalOffset:(CGFloat)voffset
                 mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
    }
}
 

-(void)drawCorners{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * 0.20];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : cornerFont}];
    

    CGRect textBounds;
    textBounds.origin = CGPointMake(2.0, 2.0);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    [self pushContextAndRotateUpSideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
    
}

-(void)pushContextAndRotateUpSideDown
{
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}
-(void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
    
}

-(NSString *)rankAsString{
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void)setSuit:(NSString *)suit{
    _suit = suit;
    [self setNeedsDisplay];
}
-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}
-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Initialization

-(void)setup
{
    // do initialization here
}
-(void)awakeFromNib
{
    [self setup];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
