//
//  Deck.h
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

// add card in the begining of the list
- (void)addCard: (Card * )card atTop:(BOOL)atTop;

// add card in the end of the list
- (void)addCard: (Card * )card;

// draw random card from the deck
- (Card *)drawRandomCard;

// return the number of cards in the deck
- (NSUInteger)getNumberOfCardsInDeck;

@end
