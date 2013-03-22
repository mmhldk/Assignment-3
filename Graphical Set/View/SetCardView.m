//
//  SetCardView.m
//  Graphical Set
//
//  Created by Martin on 18/03/13.
//  Copyright (c) 2013 Martin. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define COURNER_RADIUS 12.0
#define SYMBOL_OFFSET 0.2;
#define SYMBOL_LINE_WIDTH 0.02;
#define OVAL_WIDTH 0.12
#define OVAL_HEIGHT 0.4


#define STRIPES_OFFSET 0.03
#define STRIPES_ANGLE 5
#define DIAMOND_SIZE_HORIZONTAL 0.6
#define DIAMOND_SIZE_VERTICAL 0.2

#define OVAL_SIZE_HORIZONTAL 0.7
#define OVAL_SIZE_VERTICAL 0.15
#define OVAL_ROUNDED_CORNERS 100

#define COLOR_ALPHA 1
#define POINT_OFFSET 0.3
#define POINT_OFFSET_3 0.6

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:COURNER_RADIUS];
    
    [roundedRect addClip];
    if (self.faceUp) {
        [[UIColor grayColor] setFill];
    }else{
        [[UIColor whiteColor] setFill];
    }
    UIRectFill(self.bounds);
    
    [[UIColor blackColor]setStroke];
    //[roundedRect stroke];
    
    CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    if ([self.number isEqualToNumber: @1]) {
        [self drawSymbolAtPoint:point];
    }else if ([self.number isEqualToNumber:@2]){
        [self drawSymbolAtPoint:CGPointMake(point.x, point.y + point.y*POINT_OFFSET)];
        [self drawSymbolAtPoint:CGPointMake(point.x, point.y - point.y*POINT_OFFSET)];
    }else if ([self.number isEqualToNumber:@3]){
        [self drawSymbolAtPoint:CGPointMake(point.x, point.y + point.y*POINT_OFFSET_3)];
        [self drawSymbolAtPoint:point];
        [self drawSymbolAtPoint:CGPointMake(point.x, point.y - point.y*POINT_OFFSET_3)];
    }
}


- (void)shadePath:(UIBezierPath *)bezierPath
{
    
    [[self colorPath] setStroke];
    [bezierPath stroke];
    
    if([self.shading isEqualToString:@"open"]){
        [[UIColor clearColor] setFill];
    }
    if([self.shading isEqualToString:@"solid"]){
        [[self colorPath] setFill];
        
    }
    if([self.shading isEqualToString:@"striped"]){
        [[UIColor clearColor] setFill];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        [bezierPath addClip];
        
        UIBezierPath *stripes = [[UIBezierPath alloc] init];
        
        CGPoint start = self.bounds.origin;
        CGFloat nextPointInterval = self.bounds.size.width * STRIPES_OFFSET;
        start.x += nextPointInterval;
        CGPoint end = start;
        end.y = self.bounds.size.height;
        
        while (start.x < self.bounds.size.width) {
            [stripes moveToPoint:start];
            [stripes addLineToPoint:end];
            start.x += nextPointInterval;
            end.x += nextPointInterval;
        }

        stripes.lineWidth = self.bounds.size.width / 2 * SYMBOL_LINE_WIDTH;
        [stripes stroke];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    }
    
    [bezierPath fill];
}

- (void)drawOvalAtPoint:(CGPoint)point;
{
    UIBezierPath *ovalBezierPath = [UIBezierPath
                                    bezierPathWithRoundedRect:CGRectMake(
                                                                         point.x-(self.bounds.size.width * OVAL_SIZE_HORIZONTAL/2),
                                                                         point.y-(self.bounds.size.height* OVAL_SIZE_VERTICAL/2),
                                                                         self.bounds.size.width * OVAL_SIZE_HORIZONTAL,
                                                                         self.bounds.size.height * OVAL_SIZE_VERTICAL)
                                    cornerRadius:OVAL_ROUNDED_CORNERS];
    
    
    ovalBezierPath.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    [self shadePath:ovalBezierPath];
    [ovalBezierPath stroke];
}

- (void)drawDiamondAtPoint:(CGPoint)point;
{
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    
    [bezierPath moveToPoint:CGPointMake(point.x -(self.bounds.size.width * DIAMOND_SIZE_HORIZONTAL/2) , point.y)];
    [bezierPath addLineToPoint:CGPointMake(point.x, (point.y-(self.bounds.size.height * DIAMOND_SIZE_VERTICAL/2)))];
    [bezierPath addLineToPoint:CGPointMake((point.x+(self.bounds.size.width * DIAMOND_SIZE_HORIZONTAL/2)), point.y)];
    [bezierPath addLineToPoint:CGPointMake(point.x, (point.y+(self.bounds.size.height * DIAMOND_SIZE_VERTICAL/2)))];
    [bezierPath closePath];
 
    bezierPath.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    [self shadePath:bezierPath];
    
    

}
-(UIColor *)colorPath
{
    return [UIColor colorWithRed:[self.color[0] floatValue] green:[self.color[1] floatValue] blue:[self.color[2] floatValue] alpha:COLOR_ALPHA];
}

#define ROUNDING_FACTOR 0.5
#define SQUIGGLE_SIZE_VERTICAL 0.2
#define SQUIGGLE_SIZE_HORIZONTAL 0.4
- (void)drawSquiggleAtPoint:(CGPoint)point;
{
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    
    CGFloat xSquiggleSize = (self.bounds.size.width * SQUIGGLE_SIZE_HORIZONTAL/2);
    CGFloat ySquiggleSize = (self.bounds.size.height*SQUIGGLE_SIZE_VERTICAL/2);
    
    [squiggle moveToPoint:CGPointMake(point.x - xSquiggleSize, point.y - ySquiggleSize)];
    [squiggle addQuadCurveToPoint:CGPointMake(point.x - xSquiggleSize, point.y + ySquiggleSize)
                     controlPoint:CGPointMake(point.x - xSquiggleSize / ROUNDING_FACTOR, point.y + ySquiggleSize*ROUNDING_FACTOR)];
    
    [squiggle addCurveToPoint:CGPointMake(point.x + xSquiggleSize, point.y + ySquiggleSize)
                controlPoint1:CGPointMake(point.x - xSquiggleSize * 0.1, point.y - ySquiggleSize * 0.2)
                controlPoint2:CGPointMake(point.x + xSquiggleSize * 0.1, point.y + ySquiggleSize*2)];
    

    [squiggle addQuadCurveToPoint:CGPointMake(point.x + xSquiggleSize, point.y - ySquiggleSize)
                     controlPoint:CGPointMake(point.x + xSquiggleSize / ROUNDING_FACTOR, point.y - ySquiggleSize*ROUNDING_FACTOR)];
    
    [squiggle addCurveToPoint:CGPointMake(point.x - xSquiggleSize, point.y - ySquiggleSize)
                controlPoint1:CGPointMake(point.x + xSquiggleSize * 0.1, point.y + ySquiggleSize * 0.2)
                controlPoint2:CGPointMake(point.x - xSquiggleSize * 0.1, point.y - ySquiggleSize*2)];

    
    squiggle.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    [self shadePath:squiggle];
}

- (void)drawSymbolAtPoint:(CGPoint)point
{
    if([self.symbol isEqualToString:@"oval"]){
        [self drawOvalAtPoint:point];
    }else if([self.symbol isEqualToString:@"diamond"]){
        [self drawDiamondAtPoint:point];
    }else if([self.symbol isEqualToString:@"squiggle"]){
        [self drawSquiggleAtPoint:point];
    }
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

-(void)setColor:(NSArray *)color
{
    _color = color;
    [self setNeedsDisplay];
}
-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}
-(void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}
-(void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}
-(void)setNumber:(NSNumber *)number
{
    _number = number;
    [self setNeedsDisplay];
}

@end
