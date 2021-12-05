//
//  ViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import "CardGameViewController.h"

#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "Grid.h"

#import "PlayingCard.h"
#import "PlayingCardView.h"


@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *cardsViews; // alighn with game.cards

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet UIView *cardsPlaceHolderView;

@property (strong, nonatomic) Grid *grid;

@end

@implementation CardGameViewController



- (void)viewDidLoad{
  _cardsViews = [[NSMutableArray alloc] init];
  _game = [[CardMatchingGame alloc] initWithCardCount:[self getInitCardCount] usingDeck:[self createDeck] inMatchMode:[self getMatchMode]];
  
  _grid = [[Grid alloc] init];
  _grid.size = self.cardsPlaceHolderView.bounds.size;
  _grid.minimumNumberOfCells = [self.game getNumberOfCardsInGame];
  _grid.cellAspectRatio = [self getCardRatio];
  
  [self initCardsViewInPlaceHolder];
  [self updateUI];
  
}


- (void)initCardsViewInPlaceHolder {
  if (!_cardsViews) {
    _cardsViews = [[NSMutableArray alloc] init];
  }
  
  NSUInteger cardIndex = 0;
  CGRect frame;
  for (int row = 0; row < self.grid.rowCount; row++) {
    for (int col = 0; col < self.grid.columnCount; col++) {
      Card *card = [self.game cardAtIndex:cardIndex];
      frame = [self.grid frameOfCellAtRow:row inColumn:col];
      
      if (card) {
        UIView *cardView = [self createViewOfCard:card inFrame:frame];
        [self.cardsViews addObject:cardView];
      }
      cardIndex++;
    }
  }
  
}

- (void) updateUI {
  for(int i = 0; i < self.cardsViews.count; i++){
    Card *card = [self.game cardAtIndex:i];
    UIView *cardView = self.cardsViews[i];
    
    [self updateCardView:cardView usingCard:card animation:YES];
    [self.cardsPlaceHolderView addSubview:cardView];
    
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
}

- (void)resetGame {
    self.game = nil;
    [self updateUI];
}

- (IBAction)onClickResetButton:(UIButton *)sender {
    [self resetGame];
}

- (IBAction)tapOnCard:(UITapGestureRecognizer *)sender {
  CGPoint tapLocation = [sender locationInView:self.cardsPlaceHolderView];
  NSInteger index = -1;
  UIView *cardView;
  for (int i = 0; i<self.cardsViews.count; i++) {
    cardView = self.cardsViews[i];
    if (CGRectContainsPoint(cardView.frame, tapLocation)) {
      index = i;
      break;
    }
  }
  if (index > -1) {
    [self.game chooseCardAtIndex:index];
    [self updateUI];
  }
}


- (Deck *)createDeck {
  return nil;
} // abstract

- (NSUInteger)getInitCardCount {
  return 0;
} //abstract

- (NSInteger)getMatchMode {
  return 0;
} //abstract

- (BOOL)addCardsAfterMatched {
  return nil;
} //abstract

- (CGFloat)getCardRatio {
  return 0;
} //abstract

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame {
  return nil;
} //abstract

- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate {
} //abstract


@end
