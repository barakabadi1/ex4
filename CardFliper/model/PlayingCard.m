//
//  PlayingCard.m
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "PlayingCard.h"

@implementation PlayingCard




- (int)match:(NSArray *)otherCards{
    int score = 0;
    if (otherCards.count == 1) { //2 cards match
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        }else if ([otherCard.suit isEqualToString:self.suit]){
            score=1;
        }
    }else if(otherCards.count == 2){
        PlayingCard *card1 = [otherCards firstObject];
        PlayingCard *card2 = [otherCards lastObject];
        
        // rank matching score
        if (self.rank == card1.rank || self.rank == card2.rank) {
            score +=4;
            if (card1.rank == card2.rank) {
                score+=4;
            }
        }else if (card1.rank == card2.rank){
            score+=4;
        }
        
        // suit matching score
        if ([self.suit isEqualToString:card1.suit] || [self.suit isEqualToString:card2.suit]) {
            score +=1;
            if ([card1.suit isEqualToString:card2.suit]) {
                score+=2;
            }
        }else if ([card1.suit isEqualToString:card2.suit]){
            score+=1;
        }
        
    }
    return score;
}


-(NSString *) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;
+(NSArray *)validSuits{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit=suit;
    }
}

-(NSString *)suit{
    return _suit? _suit:@"?";
}

+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    return [[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank{
    if (rank<=[PlayingCard maxRank]) {
        _rank=rank;
    }
}


@end
