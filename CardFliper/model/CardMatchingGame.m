//
//  CardMatchingGame.m
//  CardFliper
//
//  Created by Barak Abadi on 16/11/2021.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray<Card *> *cards;
@property (nonatomic,readonly) NSUInteger matchMode;
@property (nonatomic) NSUInteger numOfChosen;
@property (nonatomic,readwrite) NSMutableArray<NSString *> *actionHistory;
@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck inMatchMode:(NSInteger)matchMode{
    
    if (self=[super init]) {
        _cards = [[NSMutableArray alloc]init];
        _matchMode = matchMode;
        for (int i =0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self=nil;
                break;
            }
        }
        _numOfChosen = 0;
        _actionHistory = [[NSMutableArray alloc] init];
    }
    return self;
}

//difult match mode - 2 cards
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    return [self initWithCardCount:count usingDeck:deck inMatchMode:2];
}

- (instancetype)init{
    return self=nil;
}


- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<self.cards.count) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index{
    
    NSString *actionString = @"";
    Card *card = [self cardAtIndex:index];
    NSMutableArray<Card *> *chosenCards = [[NSMutableArray alloc] init];
    if (!card.matched) {
        if (card.chosen) {
            card.chosen=NO;
            _numOfChosen--;
            actionString = [NSString stringWithFormat:@"Unchoose %@",card.contents];
        }else if(_numOfChosen == _matchMode-1){ //if we chose full group
            for(Card *otherCard in self.cards){ //find the chosen cards
                if (otherCard.chosen && !otherCard.matched) {
                    [chosenCards addObject:otherCard];
                }
            }
            card.chosen = YES;
            int matchScore = [card match:chosenCards];
            
            if (matchScore) { //match found
                self.score += matchScore * MATCH_BONUS;
                actionString = @"matched cards: ";
                for (Card *mCard in chosenCards) { //mark card as matched
                    mCard.matched = YES;
                    actionString = [actionString stringByAppendingFormat:@"%@,",mCard.contents];
                }
                card.matched = YES;
                _numOfChosen = 0;
                actionString = [actionString stringByAppendingFormat:@"%@",card.contents];

                
            }else{ // match not found
                self.score -=MISMATCH_PENALTY;
                actionString = @"miss matched cards: ";
                for (Card *mCard in chosenCards) { //mark card as matched
                    mCard.chosen = NO;
                    actionString = [actionString stringByAppendingFormat:@"%@,",mCard.contents];

                }
                _numOfChosen=1;
                actionString = [actionString stringByAppendingFormat:@"%@",card.contents];

            }
        }else{ //not full group chosen
            card.chosen=YES;
            _numOfChosen++;
            actionString = [NSString stringWithFormat:@"choose %@",card.contents];
        }
        self.score -= COST_TO_CHOOSE;
        [self.actionHistory addObject:actionString];
    }
}


@end
