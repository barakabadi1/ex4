//
//  SetCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "SetCardGameViewController.h"

#import "HistoryViewController.h"

#import "model/SetCardDeck.h"
#import "model/SetCard.h"
#import "model/CardMatchingGame.h"

@interface SetCardGameViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;

@property (strong, nonatomic) HistoryViewController *historyController;

@end

@implementation SetCardGameViewController


- (void)viewDidLoad{
  _historyController = [[HistoryViewController alloc] init];
  [self updateUI:NO];
}

- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck] inMatchMode:[self getMatchMode]];
    return _game;
}

- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}

-(NSInteger) getMatchMode{
  return 3;
}

-(void) updateUI:(BOOL)isReset{
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
   
    [cardButton setBackgroundColor:[self backgroundColorForCard:card]];
    
    [cardButton setAttributedTitle:[self textOfCard:card] forState:UIControlStateNormal];
  }
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
  self.lastActionLabel.attributedText = [self lastActionTitle];

  if (isReset){
    self.historyController = [[HistoryViewController alloc] init];
  }else if(self.game.action){
    [self saveHistory:[self lastActionTitle] withScore:self.game.score];
  }
}

- (NSAttributedString *)lastActionTitle{
  if (!self.game.action) {
    return [[NSAttributedString alloc] initWithString:@"Press any card to start the game"];
  }
  NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:[self.game.action.action stringByAppendingString:@" :"]];
  
  for (SetCard *card in self.game.action.cards) {
    [title appendAttributedString:[self textOfCard:card]];
    [title appendAttributedString: [[NSAttributedString alloc] initWithString:@", "]];
  }
  
  return title;
  
}

- (void)saveHistory:(NSAttributedString *)action withScore:(NSInteger)score{
  [self.historyController addActionToHistory:action withScore:score];
}

- (UIColor *)backgroundColorForCard:(Card *)card{
  return card.chosen ? [UIColor lightGrayColor] : [UIColor whiteColor];
}


- (NSAttributedString *)textOfCard:(SetCard *)card{
  NSString *shape = @"";
  for (int i = 0; i <= card.numOfSymbol; i++) {
    shape = [shape stringByAppendingFormat:@"%@",card.shape];
  }
  
  NSNumber *stroke;
  CGFloat alpha = 1;
  switch (card.shading) {
    case 0: // solid
      stroke = @0;
      alpha = 1;
      break;
    case 1: // outlined
      stroke = @5;
      alpha = 1;
      break;
    case 2: // low alpha
      stroke = @0;
      alpha = 0.5;
      break;
  }
  
  UIColor *colorUi;
  switch (card.color) {
    case 0: // red
      colorUi = [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
      break;
    case 1: // green
      colorUi = [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
      break;
    case 2: // purple
      colorUi = [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:alpha];
  }
  
  
  NSDictionary *attributeDict = @{NSForegroundColorAttributeName:colorUi,
                                  NSStrokeWidthAttributeName:stroke,
                                  NSStrokeColorAttributeName:colorUi
                                  
  };
  
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:shape];
  [text addAttributes:attributeDict range:NSMakeRange(0,[shape length])];

  return text;
  
}

@end
