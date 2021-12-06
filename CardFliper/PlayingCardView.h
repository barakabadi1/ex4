//
//  PlayingCardView.h
//  CardFliper
//
//  Created by Barak Abadi on 01/12/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : UIView

// the rank of the card
@property (nonatomic) NSUInteger rank;

// the suit of the card
@property (strong, nonatomic) NSString *suit;

// mark if the card face up
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
