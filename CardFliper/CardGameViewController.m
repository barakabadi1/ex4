//
//  ViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import "CardGameViewController.h"
#import "model/Deck.h"
#import "model/CardMatchingGame.h"


@interface CardGameViewController ()

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (strong, nonatomic) IBOutlet UISlider *historySlider;

@end

@implementation CardGameViewController

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

        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];

        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.matched;

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
    self.gameMode.enabled = isReset;
//    self.historySlider.maximumValue = self.game.actionHistory.count;
    self.lastActionLabel.text = isReset? @"Press any card to start the game": [self currentActionString];

}


-(NSString *) currentActionString{
    [self.historySlider setValue:self.historySlider.maximumValue];
    return [self.game.actionHistory lastObject];
}


-(NSString *) titleForCard:(Card *) card{
    return card.chosen? card.contents:@"";
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

- (IBAction)historySliderChanges:(UISlider *)sender {
    if(self.game && self.game.actionHistory.count){
        NSInteger index = (sender.value * self.game.actionHistory.count) - 1;
        index = index<0 ? 0: index;
        self.lastActionLabel.text = self.game.actionHistory[index];
    }
}

@end
