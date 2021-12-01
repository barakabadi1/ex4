//
//  PlayingCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "PlayingCardGameViewController.h"

#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{
  return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.playingCardView.suit = @"♣️";
  self.playingCardView.rank = 13;
  self.playingCardView.faceUp = YES;
}

- (IBAction)tapOnCard:(UITapGestureRecognizer *)sender {
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}


@end
