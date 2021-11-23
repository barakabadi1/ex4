//
//  PlayingCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "PlayingCardGameViewController.h"

#import "model/PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{
  return [[PlayingCardDeck alloc] init];
}

@end
