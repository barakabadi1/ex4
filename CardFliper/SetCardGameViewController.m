//
//  SetCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "SetCardGameViewController.h"


#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController


- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}

-(NSInteger) getMatchMode{
  return 3;
}

- (NSUInteger)getInitCardCount {
  return 12;
}


- (BOOL)addCardsAfterMatched {
  return YES;
}

- (CGFloat)getCardRatio {
  return 0.7;
}

-(NSUInteger)amountOfCardsToAdd{
  return 3;
}

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame {
  return nil;
}

- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate{
  
}

//-(void) updateUI:(BOOL)isReset{
//  for (UIButton *cardButton in self.cardButtons) {
//    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//    SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
//   
//    [cardButton setBackgroundColor:[self backgroundColorForCard:card]];
//    
//    [cardButton setAttributedTitle:[self textOfCard:card] forState:UIControlStateNormal];
//  }
//  
//  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
//
//}


- (UIColor *)backgroundColorForCard:(Card *)card{
  return card.chosen ? [UIColor lightGrayColor] : [UIColor whiteColor];
}


- (NSAttributedString *)textOfCard:(SetCard *)card{
  NSString *shape = @"";
  for (int i = 0; i <= card.numOfSymbol; i++) {
    shape = [shape stringByAppendingFormat:@"%@",card.shape];
  }
  
  NSNumber *stroke;
  CGFloat alpha = 1;
  switch (card.shading) {
    case 0: // solid
      stroke = @0;
      alpha = 1;
      break;
    case 1: // outlined
      stroke = @5;
      alpha = 1;
      break;
    case 2: // low alpha
      stroke = @0;
      alpha = 0.5;
      break;
  }
  
  UIColor *colorUi;
  switch (card.color) {
    case 0: // red
      colorUi = [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
      break;
    case 1: // green
      colorUi = [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
      break;
    case 2: // purple
      colorUi = [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:alpha];
  }
  
  
  NSDictionary *attributeDict = @{NSForegroundColorAttributeName:colorUi,
                                  NSStrokeWidthAttributeName:stroke,
                                  NSStrokeColorAttributeName:colorUi
                                  
  };
  
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:shape];
  [text addAttributes:attributeDict range:NSMakeRange(0,[shape length])];

  return text;
  
}

@end
