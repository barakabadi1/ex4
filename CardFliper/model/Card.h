#import <Foundation/Foundation.h>

@interface Card : NSObject


// check if cards are matched and return the score
- (int)match:(NSArray *)otherCards;


// string description of the card
@property (strong, nonatomic) NSString *contents;

// mark if card is chosen
@property (nonatomic) BOOL chosen;

// mark if card is matched
@property (nonatomic) BOOL matched;



@end
