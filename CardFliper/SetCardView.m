//
//  SetCardView.m
//  CardFliper
//
//  Created by Barak Abadi on 06/12/2021.
//

#import "SetCardView.h"

@implementation SetCardView

//solid - 0
// striped - 1
//empty - 3

- (void)drawRect:(CGRect)rect {
    // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath
                                bezierPathWithRoundedRect:self.bounds
                                             cornerRadius:8.0];
  [roundedRect addClip];
  
  if (self.faceUp) {
      [[UIColor lightGrayColor] setFill];
      UIRectFill(self.bounds);
  } else {
      [[UIColor whiteColor] setFill];
      UIRectFill(self.bounds);
  }
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  [self drawCards];

}

- (void)drawCards {
  if (self.shapeIndex == 0) { //dimond
    [self drawDimond];
  } else if (self.shapeIndex == 1) { //squiggle
    [self drawSquiggle];
  } else { //oval
    [self drawOval];
  }
}


#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
  return [self cornerRadius] / 3.0;
}


- (void)setColor:(NSUInteger)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)setShapeIndex:(NSUInteger)shapeIndex {
  _shapeIndex = shapeIndex;
  [self setNeedsDisplay];
}

- (void)setShading:(NSUInteger)shading {
  _shading = shading;
  [self setNeedsDisplay];
}

- (void)setNumOfSymbol:(NSUInteger)numOfSymbol {
  _numOfSymbol = numOfSymbol;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}


#define SYMBOL_SCALE_X 2
#define SYMBOL_SCALE_Y 7

#define DIAMOND_ARM_SCALE 0.8

#define SIZE_OF_OVAL_CURVE 10

#define SHAPE_LINEWIDTH 4.0

#define Y_OFFSET_FOR_NUMBER_2 2.7
#define Y_OFFSET_FOR_NUMBER_3 1.7

- (void)drawSquiggle {
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  
  CGPoint start = CGPointMake(middle.x + (middle.x / SYMBOL_SCALE_X),
                              middle.y - (middle.y / SYMBOL_SCALE_Y));
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  
  [path moveToPoint:start];
  [path addQuadCurveToPoint:CGPointMake(start.x, middle.y +
                                        (middle.y / SYMBOL_SCALE_Y))
               controlPoint:CGPointMake(start.x + SIZE_OF_OVAL_CURVE, middle.y)];
  
  [path addCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X),
                                    middle.y + (middle.y / SYMBOL_SCALE_Y))
          controlPoint1:CGPointMake(middle.x, middle.y +
                                    (middle.y / SYMBOL_SCALE_Y) +
                                    (middle.y / SYMBOL_SCALE_Y))
          controlPoint2:CGPointMake(middle.x, middle.y)];
  
  [path addQuadCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X), start.y)
               controlPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X) -
                                        SIZE_OF_OVAL_CURVE, middle.y)];
  
  [path addCurveToPoint:CGPointMake(start.x, start.y)
          controlPoint1:CGPointMake(middle.x, middle.y -
                                    (middle.y / SYMBOL_SCALE_Y) -
                                    (middle.y / SYMBOL_SCALE_Y))
          controlPoint2:CGPointMake(middle.x, middle.y)];

  [path closePath];
  path.lineWidth =SHAPE_LINEWIDTH;
  
  [self drawAttributesFor:path];

}

- (void)drawDimond {
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGPoint start = CGPointMake(middle.x, middle.y - (middle.y / SYMBOL_SCALE_Y));
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:start];
  [path addLineToPoint:CGPointMake(middle.x + (middle.x / (SYMBOL_SCALE_X * DIAMOND_ARM_SCALE)),
                                   middle.y)];
  [path addLineToPoint:CGPointMake(middle.x, middle.y + (middle.y / SYMBOL_SCALE_Y))];
  [path addLineToPoint:CGPointMake(middle.x - (middle.x / (SYMBOL_SCALE_X * DIAMOND_ARM_SCALE)),
                                   middle.y)];
  [path closePath];

  path.lineWidth = SHAPE_LINEWIDTH;
  
  [self drawAttributesFor:path];

}


- (void)drawOval {
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGPoint start = CGPointMake(middle.x + (middle.x / SYMBOL_SCALE_X),
                              middle.y - (middle.y / SYMBOL_SCALE_Y));
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:start];
  [path addQuadCurveToPoint:CGPointMake(start.x, middle.y + (middle.y / SYMBOL_SCALE_Y))
               controlPoint:CGPointMake(start.x + SIZE_OF_OVAL_CURVE, middle.y)];
  [path addLineToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X),
                                   middle.y + (middle.y / SYMBOL_SCALE_Y))];
  [path addQuadCurveToPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X), start.y)
               controlPoint:CGPointMake(middle.x - (middle.x / SYMBOL_SCALE_X) -
                                        SIZE_OF_OVAL_CURVE, middle.y)];
  [path closePath];

  path.lineWidth = SHAPE_LINEWIDTH;
  
  [self drawAttributesFor:path];

}



- (void)drawAttributesFor:(UIBezierPath *)path {
  NSArray *colors  = @[[UIColor redColor],
                       [UIColor greenColor],
                       [UIColor purpleColor]];
  UIColor *cardColor = colors[self.color];
  
  [cardColor setStroke];
  
  if (self.shading == 0 || self.shading == 1) {
    [cardColor setFill];
  }
                                  
  if (self.numOfSymbol == 1) {
    CGFloat yOffset = self.bounds.size.height/2/Y_OFFSET_FOR_NUMBER_2;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -yOffset);
    [path applyTransform:transform];
    [self drawPath:path];
    
    transform = CGAffineTransformMakeTranslation(0, yOffset * 2);
    [path applyTransform:transform];
    [self drawPath:path];
    
  } else if (self.numOfSymbol == 2) {
    CGFloat yOffset = self.bounds.size.height/2/Y_OFFSET_FOR_NUMBER_3;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -yOffset);
    [path applyTransform:transform];
    [self drawPath:path];
    
    transform = CGAffineTransformMakeTranslation(0, yOffset);
    [path applyTransform:transform];
    [self drawPath:path];
    
    transform = CGAffineTransformMakeTranslation(0, yOffset);
    [path applyTransform:transform];
    [self drawPath:path];
      
  } else {
    [self drawPath:path];
  }
}

- (void) drawPath:(UIBezierPath* )path {
  [path stroke];
  
  if (self.shading == 1){
    [path fill];
    [self stripes:path];
    
  } else {
    [path fill];
  }
}


static void drawStripes (void *info, CGContextRef context) {
  CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
  CGContextFillRect(context, CGRectMake(0,0,2,1));
}

- (void)stripes: (UIBezierPath* )path {
  CGContextRef context=UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  [path addClip];
  
  CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(nil);
  CGContextSetFillColorSpace (context, sp2);
  CGColorSpaceRelease (sp2);
  static const CGPatternCallbacks callback = {0, drawStripes, nil};
  CGAffineTransform transform = CGAffineTransformIdentity;
  CGPatternRef pattern = CGPatternCreate(nil,
                                      CGRectMake(0,0,3,1),
                                      transform,
                                      3, 1,
                                      kCGPatternTilingConstantSpacingMinimalDistortion,
                                      true,
                                      &callback);
  CGFloat alpha = 1.0;
  CGContextSetFillPattern(context, pattern, &alpha);
  CGPatternRelease(pattern);
  CGContextFillRect(context, self.bounds);
  
  CGContextRestoreGState(context);
}




- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}

@end
