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
  PlayingCard *pCard = (PlayingCard *)card;
  PlayingCardView *pCardView = (PlayingCardView *)cardView;
  pCardView.suit = pCard.suit;
  pCardView.rank = pCard.rank;
  pCardView.faceUp = card.chosen;
}

@end
