//
//  Deck.m
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "Deck.h"

@interface Deck()

// array of cards
@property (strong,nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }else{
    [self.cards addObject:card];
  }
}

- (void)addCard:(Card *)card {
  [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
  Card *randomCard = nil;
  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
  return randomCard;
}


- (NSUInteger)getNumberOfCardsInDeck {
  return self.cards.count;
}

@end
