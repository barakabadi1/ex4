//
//  PlayingCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "PlayingCardGameViewController.h"

#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

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

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame{
  PlayingCard *pCard = (PlayingCard *)card;
  PlayingCardView *pCardView = [[PlayingCardView alloc] initWithFrame:frame];
  pCardView.suit = pCard.suit;
  pCardView.rank = pCard.rank;
  pCardView.faceUp = card.chosen;
  
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
                      completion:NULL];
    }else{
      pCardView.faceUp = pCard.chosen;
    }
  }

}

@end
