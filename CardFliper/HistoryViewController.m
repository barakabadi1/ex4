//
//  HistoryViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 25/11/2021.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (instancetype)init{
  if (self=[super init]) {
    _actionHistory = [[NSMutableArray alloc] init];
    _scoreHistory = [[NSMutableArray alloc] init];
  }
  return self;

}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateUI];
}

- (void)addActionToHistory:(NSAttributedString *)action withScore:(NSInteger)score{
  [self.actionHistory addObject:action];
  [self.scoreHistory addObject:[NSNumber numberWithInteger:score]];
}


- (void)updateUI{
  NSNumber *lastScore = @0;
  NSMutableAttributedString *fullText = [[NSMutableAttributedString alloc] init];
  
  if (!self.actionHistory.count) {
    fullText = [fullText initWithString:@"No action was made"];
  }else{
    for (int i = 0; i < self.actionHistory.count; i++) {
      NSNumber *points = @(self.scoreHistory[i].intValue - lastScore.intValue);
      lastScore = self.scoreHistory[i];
      NSAttributedString *scoreString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" points: %@\n",points.stringValue]];
      
      [fullText appendAttributedString:self.actionHistory[i]];
      [fullText appendAttributedString:scoreString];
    }
  }
  self.historyTextView.attributedText = fullText;
}

@end
