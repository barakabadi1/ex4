//
//  PlayingCardDeck.m
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "PlayingCardDeck.h"

#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init{
  if (self = [super init]) {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank=1;rank<=[PlayingCard maxRank];rank++) {
        PlayingCard *card = [[PlayingCard alloc] init];
        card.rank  = rank;
        card.suit = suit;
        [self addCard:card];
      }
    }
  }
  return self;
}

@end
