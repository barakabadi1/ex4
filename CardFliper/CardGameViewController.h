//
//  ViewController.h
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import <UIKit/UIKit.h>

#import "Card.h"

@class Deck;

@interface CardGameViewController : UIViewController

// create deck for the game
- (Deck *)createDeck; // abstract

// get the number of cards to begin the game with
- (NSUInteger)getInitCardCount; //abstract

// get the match mode
- (NSInteger)getMatchMode; //abstract

// mark if add cards after matche is needed
- (BOOL)addCardsAfterMatched; //abstract

// return the card ratio
- (CGFloat)getCardRatio; //abstract

// return the number of cards to add
- (NSUInteger)amountOfCardsToAdd; //abstract

// create a card view from card in frame
- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame; //abstract

// update the card view with card and anumation is optional
- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate; //abstract

@end

