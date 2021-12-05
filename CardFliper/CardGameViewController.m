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



- (void)setupNewCardGame {
  _cardsViews = [[NSMutableArray alloc] init];
  _game = [[CardMatchingGame alloc] initWithCardCount:[self getInitCardCount] usingDeck:[self createDeck] inMatchMode:[self getMatchMode]];
  _grid = [[Grid alloc] init];

}

- (void)setupGridLayout {
  _grid.size = self.cardsPlaceHolderView.bounds.size;
  _grid.minimumNumberOfCells = [self.game getNumberOfCardsInGame];
  _grid.cellAspectRatio = [self getCardRatio];
}

- (void)viewDidLoad{
  
  [self setupNewCardGame];
  [self setupGridLayout];
  
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
        UIView *cardView = [self createViewOfCard:card inFrame:CGRectMake(0.0,
                                                                          self.cardsPlaceHolderView.bounds.size.height,
                                                                          self.grid.cellSize.width,
                                                                          self.grid.cellSize.height)];
        cardView.hidden = YES;
        [self.cardsViews addObject:cardView];
        [self.cardsPlaceHolderView addSubview:cardView];
        [UIView animateWithDuration:0.1
                              delay:0.1+(cardIndex*0.1)
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{ cardView.hidden = NO;
                                       cardView.frame = frame;
                                      }
                         completion:nil];
      }
      cardIndex++;
    }
  }
  
}

- (void)redrawCardsInPlaceHolder {
  
  [self setupGridLayout];
  
  NSUInteger cardViewIndex = 0;
  CGRect newFrame;
  for (int row = 0; row < self.grid.rowCount; row++) {
    for (int col = 0; col < self.grid.columnCount; col++) {
      
      if (cardViewIndex >= self.cardsViews.count) {
        return;
      }
      
      UIView *cardView = self.cardsViews[cardViewIndex];
      while (cardViewIndex < self.cardsViews.count-1 && cardView.alpha == 0) {
        cardViewIndex++;
        cardView = self.cardsViews[cardViewIndex];
      }
      
        newFrame = [self.grid frameOfCellAtRow:row inColumn:col];
        if (!CGRectEqualToRect(cardView.frame, newFrame) && cardViewIndex < self.cardsViews.count) {
          [UIView animateWithDuration:0.2f
                                delay:0.0f
                              options:UIViewAnimationOptionCurveEaseInOut
                           animations:^{ cardView.frame = newFrame; }
                           completion:nil];
        }
      cardViewIndex++;
    }
  }
  
}

- (void) updateUI {
  for(int i = 0; i < self.cardsViews.count; i++){
    Card *card = [self.game cardAtIndex:i];
    UIView *cardView = self.cardsViews[i];
    
    if (cardView.alpha != 0) {
      if (card.matched) {
        [self removeCardsFromGrid];
      } else {
        [self updateCardView:cardView usingCard:card animation:YES];
         // todo - move to other method with animation of start
      }
    }

  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
}



- (IBAction)tapOnCard:(UITapGestureRecognizer *)sender {
  
  //todo - add behaivior to the pinched view
  
  CGPoint tapLocation = [sender locationInView:self.cardsPlaceHolderView];
  NSInteger index = -1;
  UIView *cardView;
  for (int i = 0; i<self.cardsViews.count; i++) {
    cardView = self.cardsViews[i];
    if (cardView.alpha != 0 && CGRectContainsPoint(cardView.frame, tapLocation)) {
      index = i;
      break;
    }
  }
  if (index > -1) {
    [self.game chooseCardAtIndex:index];
    [self updateUI];
  }
}


- (void)removeCardsFromGrid {
  NSArray *indexesOfMatchedCards = [self.game getIndexesOfMatchedCards];
  NSMutableArray *cardsViewsToRemove = [[NSMutableArray alloc] init];
  
  for (NSNumber *indexNumber in indexesOfMatchedCards) {
    int index = [indexNumber intValue];
    
    UIView *cardView = self.cardsViews[index];
    if (cardView.alpha != 0) {
      [cardsViewsToRemove addObject:cardView];
    }
  }
  
  [UIView animateWithDuration:0.5
                   animations:^{ for (UIView *cardView in cardsViewsToRemove) { cardView.alpha = 0; } }
                   completion:^(BOOL finished){
    if ([self addCardsAfterMatched]) {
      [self addCardsToGame];
    }
    [self redrawCardsInPlaceHolder];
  }
  ];

}

- (void)addCardsToGame {
  NSArray *cardsToAdd = [self.game drawNewCardsFromDeck: [self amountOfCardsToAdd]];
    
  for (Card *card in cardsToAdd) {
    UIView *cardView = [self createViewOfCard:card inFrame:CGRectMake(0.0,
                                                                      self.cardsPlaceHolderView.bounds.size.height,
                                                                      self.grid.cellSize.width,
                                                                      self.grid.cellSize.height)];
    [self.cardsViews addObject:cardView];
    [self.cardsPlaceHolderView addSubview:cardView];
  }
    
}


- (void)removeAllCardsViewsFromPlaceHolder{
  for (UIView *view in [self.cardsPlaceHolderView subviews]) {
      [UIView animateWithDuration:0.5
                       animations:^{view.frame = CGRectMake(0.0,
                                                            self.cardsPlaceHolderView.bounds.size.height,
                                                            self.grid.cellSize.width,
                                                            self.grid.cellSize.height);
                       } completion:^(BOOL finished) {
                           [view removeFromSuperview];
                       }];
  }
}


- (void)resetGame { // todo - change to method with animation and reset views
  
  [self removeAllCardsViewsFromPlaceHolder];
  
  self.game = nil;
  self.cardsViews = nil;
  
  [self setupNewCardGame];
  [self setupGridLayout];
  [self initCardsViewInPlaceHolder];
  [self updateUI];
  
}

- (IBAction)onClickResetButton:(UIButton *)sender {
    [self resetGame];
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

- (NSUInteger)amountOfCardsToAdd{
  return 0;
}

- (UIView *)createViewOfCard:(Card *)card inFrame:(CGRect)frame {
  return nil;
} //abstract

- (void)updateCardView:(UIView *)cardView usingCard:(Card *)card animation:(BOOL)toAnimate {
} //abstract



- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self redrawCardsInPlaceHolder];
}

@end
