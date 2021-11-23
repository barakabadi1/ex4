//
//  Deck.h
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard: (Card * )card atTop:(BOOL)atTop;
-(void)addCard: (Card * )card;

-(Card *)drawRandomCard;

@end
