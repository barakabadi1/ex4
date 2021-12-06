//
//  ViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import "CardGameViewController.h"

#import "CardMatchingGame.h"
#import "Deck.h"
#import "Grid.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface CardGameViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *cardsViews; // alighn with game.cards

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (strong, nonatomic) IBOutlet UIView *cardsPlaceHolderView;

@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;

@property (strong, nonatomic) Grid *grid;

@property (nonatomic) BOOL isViewsPinched;



@end

@implementation CardGameViewController



- (void)setupNewCardGame {
  _cardsViews = [[NSMutableArray alloc] init];

  _game = [[CardMatchingGame alloc] initWithCardCount:[self getInitCardCount] usingDeck:[self createDeck] inMatchMode:[self getMatchMode]];
  _grid = [[Grid alloc] init];
  
  _isViewsPinched = NO;
  
  _addCardsButton.hidden = ![self addCardsAfterMatched];
}

- (void)setupGridLayout {
  _grid.size = self.cardsPlaceHolderView.bounds.size;
  _grid.minimumNumberOfCells = [self.game getNumberOfCardsInGame];
  _grid.cellAspectRatio = [self getCardRatio];
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
  for (int i = 0; i < self.cardsViews.count; i++) {
    Card *card = [self.game cardAtIndex:i];
    UIView *cardView = self.cardsViews[i];
    
    if (cardView.alpha != 0) {
      if (card.matched) {
        [self removeCardsFromGrid];
      } else {
        [self updateCardView:cardView usingCard:card animation:YES];
      }
    }

  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
  self.addCardsButton.enabled = [self.game getNumberOfCardsInDeck] > 0;
}



- (IBAction)tapOnCard:(UITapGestureRecognizer *)sender {

  //todo - add behaivior to the pinched view
  if (!self.isViewsPinched) {
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
  } else {
    self.isViewsPinched = NO;
    [self redrawCardsInPlaceHolder];
  }

}

- (IBAction)pinchCardsViews:(UIPinchGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.cardsPlaceHolderView];
  self.isViewsPinched = YES;
  [self setFrameForCardsViewsInPinchedMode:gesturePoint];
}

#define CARD_FRAME_OFFSET 0.3

- (void)setFrameForCardsViewsInPinchedMode:(CGPoint)gesturePoint {
  int index = 0;
  for (UIView *view in [self.cardsPlaceHolderView subviews]) {
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ view.frame = CGRectMake(
                                                           gesturePoint.x - index * CARD_FRAME_OFFSET,
                                                           gesturePoint.y - index * CARD_FRAME_OFFSET,
                                                           view.frame.size.width,
                                                           view.frame.size.height); }
                     completion:nil];
    index++;
  }
}

- (IBAction)panCardsViews:(UIPanGestureRecognizer *)sender {
  if (self.isViewsPinched) {
    CGPoint gesturePoint =[sender locationInView:self.cardsPlaceHolderView];
    [self setFrameForCardsViewsInPinchedMode:gesturePoint];
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
  
  if (![self.game getNumberOfCardsInDeck]) {
    self.addCardsButton.enabled = NO;
  }
    
}


- (IBAction)addCardButtonPress:(UIButton *)sender {
  
  if (self.addCardsAfterMatched) {
    [self addCardsToGame];
  }
}


- (void)removeAllCardsViewsFromPlaceHolder {
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
  
  [self initCardGame];
  
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

- (void)initCardGame {
  [self setupNewCardGame];
  [self setupGridLayout];
  
  [self initCardsViewInPlaceHolder];
  [self updateUI];
}

- (void)viewDidLoad {
  
  [super viewDidLoad];  
  [self initCardGame];

}

@end
