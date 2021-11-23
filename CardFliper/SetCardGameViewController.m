//
//  SetCardGameViewController.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "SetCardGameViewController.h"
#import "model/SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}



-(void) updateUI:(BOOL)isReset{
  for (UIButton *cardButton in self.cardButton) {
    <#statements#>
  }

}
@end
