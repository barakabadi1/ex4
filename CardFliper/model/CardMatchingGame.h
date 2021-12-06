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

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck inMatchMode:(NSInteger)matchMode;

@property (nonatomic,readonly) NSInteger score;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSArray *)drawNewCardsFromDeck:(NSUInteger)count;

- (NSArray *)getIndexesOfMatchedCards;

- (NSUInteger)getNumberOfCardsInGame;

- (NSUInteger)getNumberOfCardsInDeck;



@end
