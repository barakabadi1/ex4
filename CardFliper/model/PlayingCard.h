//
//  PlayingCard.h
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "Card.h"

@interface PlayingCard : Card

// array of valid suits
+ (NSArray *) validSuits;

// the max rank allowd
+ (NSUInteger) maxRank;

// the suit of the card
@property (strong, nonatomic) NSString *suit;

// the rank of the card
@property (nonatomic) NSUInteger rank;



@end
