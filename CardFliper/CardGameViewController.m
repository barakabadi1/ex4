//
//  ViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import "CardGameViewController.h"

#import "Deck.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"



@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UIView *CardDisplayAreaView;

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;


@end

@implementation CardGameViewController

- (IBAction)tapOnCard:(UITapGestureRecognizer *)sender {
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad{
  [self updateUI:NO];
}

- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck] inMatchMode:[self getMatchMode]];
    return _game;
}

-(NSInteger) getMatchMode{
//    return _gameMode.selectedSegmentIndex + 2;
  return 2;
}

-(Deck *)createDeck{
    return nil;
}

- (IBAction)touchGameMode:(UISegmentedControl *)sender {
    [self resetGame];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI:NO];
}

-(void) updateUI:(BOOL)isReset{
  for(UIButton *cardButton in self.cardButtons){
      NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
      Card *card = [self.game cardAtIndex:cardButtonIndex];

      [cardButton setTitle:[self textOfCard:card]
                  forState:UIControlStateNormal];

      [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

      cardButton.enabled = !card.matched;

  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
  self.gameMode.enabled = isReset;


}


- (NSString *)textOfCard:(Card *)card{
    return [[NSString alloc] initWithString: card.chosen? card.contents:@""];
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.chosen? @"cardfront" : @"cardback"];
}

- (void)resetGame {
    self.game = nil;
    [self updateUI:YES];
}

- (IBAction)onClickResetButton:(UIButton *)sender {
    [self resetGame];
}


@end
