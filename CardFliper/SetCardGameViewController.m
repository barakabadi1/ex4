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
#import "SetCardView.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController


- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

-(NSInteger) getMatchMode {
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

  SetCardView *sCardView = nil;
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard *sCard = (SetCard *)card;
    sCardView = [[SetCardView alloc] initWithFrame:frame];
    sCardView.numOfSymbol = sCard.numOfSymbol;
    sCardView.color = sCard.color;
    sCardView.shapeIndex = sCard.shapeIndex;
    sCardView.shading = sCard.shading;
    
    sCardView.faceUp = card.chosen;
  }
  
  return sCardView;
  
}

- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate {
  
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard *sCard = (SetCard *)card;
    SetCardView *sCardView = (SetCardView *)cardView;
    sCardView.numOfSymbol = sCard.numOfSymbol;
    sCardView.color = sCard.color;
    sCardView.shapeIndex = sCard.shapeIndex;
    sCardView.shading = sCard.shading;
    
    if (toAnimate && sCardView.faceUp != sCard.chosen) {
      [UIView transitionWithView:sCardView
                        duration:0.5
                         options:UIViewAnimationOptionCurveLinear
                      animations:^{ sCardView.faceUp = sCard.chosen; }
                      completion:nil];
    }else{
      sCardView.faceUp = sCard.chosen;
    }
  }
}


@end
