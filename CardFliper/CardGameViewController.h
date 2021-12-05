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

- (Deck *)createDeck; // abstract

- (NSUInteger)getInitCardCount; //abstract

- (NSInteger)getMatchMode; //abstract

- (BOOL)addCardsAfterMatched; //abstract

- (CGFloat)getCardRatio; //abstract

-(NSUInteger)amountOfCardsToAdd;

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame; //abstract

- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate; //abstract

@end

