//
//  CardGameAction.m
//  CardFliper
//
//  Created by Barak Abadi on 25/11/2021.
//

#import "CardGameAction.h"

#import "../model/Card.h"

@implementation CardGameAction

- (instancetype)initWithAction:(NSString *)action andCards:(NSArray *)cards andScore:(NSInteger)score{
  if (self = [super init]) {
    _action = [NSString stringWithString:action];
    _cards = [NSArray arrayWithArray:cards];
    _score = score;
  }
  return self;
}

- (NSAttributedString *)attributeDescription{
  NSString *actionString = [NSString stringWithString:self.action];
  actionString = [actionString stringByAppendingString:@": "];
  for (Card *card in self.cards) {
    actionString = [actionString stringByAppendingFormat:@"%@, ",card.contents];
  }
  return [[NSAttributedString alloc] initWithString:actionString attributes:nil];
}

@end
