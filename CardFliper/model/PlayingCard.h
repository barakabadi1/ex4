//
//  PlayingCard.h
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
