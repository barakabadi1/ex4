//
//  CardMatchingGame.m
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()

// the score of the game
@property (readwrite, nonatomic) NSInteger score;

// array of cards in the game
@property (strong, nonatomic) NSMutableArray<Card *> *cards;

// match mode - 2\3
@property (readonly, nonatomic) NSUInteger matchMode;

// number of cards that been chosen
@property (nonatomic) NSUInteger numOfChosen;

// the deck of cards of the game
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck inMatchMode:(NSInteger)matchMode {
    
  if (self = [super init]) {
    
  _deck = deck;
  _cards = [[NSMutableArray alloc] init];
  _matchMode = matchMode;
  
  for (int i =0; i<count; i++) {
    Card *card = [deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
    } else {
//      self = nil;
      break;
    }
  }
  _numOfChosen = 0;
  }
  return self;
}

//difault match mode - 2 cards
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
  return [self initWithCardCount:count usingDeck:deck inMatchMode:2];
}

- (NSUInteger)getNumberOfCardsInGame {
  NSUInteger count = 0;
  for (Card *card in self.cards) {
    if (!card.matched) {
      count++;
    }
  }
  return count;
}

- (NSUInteger)getNumberOfCardsInDeck {
  return [self.deck getNumberOfCardsInDeck];
}


- (NSArray *)drawNewCardsFromDeck:(NSUInteger)count {
  NSMutableArray *addedCards = [[NSMutableArray alloc] init];
  for (int i = 0; i < count; i++) {
    Card *card = [self.deck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
      [addedCards addObject:card];
    }
  }
  return addedCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index<self.cards.count) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
    
  Card *card = [self cardAtIndex:index];
  NSMutableArray<Card *> *chosenCards = [[NSMutableArray alloc] init];
  if (!card.matched) {
    if (card.chosen) {
      card.chosen=NO;
      _numOfChosen--;
    } else if(_numOfChosen == _matchMode-1 ){ //if we chose full group
      for (Card *otherCard in self.cards) { //find the chosen cards
        if (otherCard.chosen && !otherCard.matched) {
          [chosenCards addObject:otherCard];
        }
      }
      card.chosen = YES;
      int matchScore = [card match:chosenCards];
      
      if (matchScore) { //match found
        self.score += matchScore * MATCH_BONUS;
        for (Card *mCard in chosenCards) { //mark card as matched
          mCard.matched = YES;
        }
        card.matched = YES;
        _numOfChosen = 0;

      } else { // match not found
        self.score -=MISMATCH_PENALTY;
        for (Card *mCard in chosenCards) { //mark card as matched
          mCard.chosen = NO;
        }
        _numOfChosen=1;
      }
    } else { //not full group chosen
      card.chosen=YES;
      _numOfChosen++;
    }
    
    self.score -= COST_TO_CHOOSE;
  }
}

- (NSArray *)getIndexesOfMatchedCards {
  NSMutableArray *matchedIndexes = [[NSMutableArray alloc] init];
  for (int i = 0; i < self.cards.count; i++) {
    if (self.cards[i].matched) {
      [matchedIndexes addObject:[NSNumber numberWithInt:i]];
    }
  }
  return matchedIndexes;
}


@end
