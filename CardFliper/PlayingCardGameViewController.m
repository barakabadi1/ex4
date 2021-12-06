//
//  PlayingCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "PlayingCardGameViewController.h"

#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)getInitCardCount {
  return 30;
}

- (NSInteger)getMatchMode {
  return 2;
}

- (BOOL)addCardsAfterMatched {
  return NO;
}

- (CGFloat)getCardRatio {
  return 0.7;
}

-(NSUInteger)amountOfCardsToAdd{
  return 0;
}

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame{
  
  PlayingCardView *pCardView = nil;if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *pCard = (PlayingCard *)card;
    pCardView = [[PlayingCardView alloc] initWithFrame:frame];
    pCardView.suit = pCard.suit;
    pCardView.rank = pCard.rank;
    pCardView.faceUp = card.chosen;
  }
  
  return pCardView;
}


- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate {
  if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *pCard = (PlayingCard *)card;
    PlayingCardView *pCardView = (PlayingCardView *)cardView;
    pCardView.suit = pCard.suit;
    pCardView.rank = pCard.rank;
    
    if (toAnimate && pCardView.faceUp != pCard.chosen) {
      [UIView transitionWithView:pCardView
                        duration:0.5
                         options:UIViewAnimationOptionTransitionFlipFromRight
                      animations:^{ pCardView.faceUp = pCard.chosen; }
                      completion:nil];
    }else{
      pCardView.faceUp = pCard.chosen;
    }
  }

}

@end
