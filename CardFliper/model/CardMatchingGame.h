//
//  CardMatchingGame.h
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// init the game with count cards from deck in default matchg mode of 2
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

// inint the game in matche mode with count cards from deck
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck inMatchMode:(NSInteger)matchMode;

// choose the card at index
- (void)chooseCardAtIndex:(NSUInteger)index;

// return the card from index
- (Card *)cardAtIndex:(NSUInteger)index;

// draw count new cards from the deck
- (NSArray *)drawNewCardsFromDeck:(NSUInteger)count;

// retuen the indexes of the matched cards in the game
- (NSArray *)getIndexesOfMatchedCards;

// return how many cards in the game
- (NSUInteger)getNumberOfCardsInGame;

// return how many cards in the deck
- (NSUInteger)getNumberOfCardsInDeck;

// the score of the game
@property (readonly, nonatomic) NSInteger score;

@end
