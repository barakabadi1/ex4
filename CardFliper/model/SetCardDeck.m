//
//  SetCardDeck.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

static const int SHAPE_AMOUNT = 3;
static const int SYMBOL_AMOUNT = 3;
static const int COLOR_AMOUNT = 3;
static const int SHADING_AMOUNT = 3;

- (instancetype)init{
  
  if (self=[super init]) {
    
    for (int symbol = 0; symbol < SYMBOL_AMOUNT; symbol++ ) {
      for (int shape = 0; shape < SHAPE_AMOUNT; shape++) {
        for (int color = 0; color < COLOR_AMOUNT; color++) {
          for (int shading = 0; shading < SHADING_AMOUNT; shading++) {
            SetCard *card = [[SetCard alloc] init];
            card.numOfSymbol = symbol;
            card.shape = shape;
            card.color = color;
            card.shading = shading;
            [self addCard:card];
          }
        }
      }
    }
    
  }
  
  return self;
}

@end
