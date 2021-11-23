//
//  ViewController.h
//  CardFliper
//
//  Created by Barak Abadi on 15/11/2021.
//

#import <UIKit/UIKit.h>

@class Deck;

@interface CardGameViewController : UIViewController

- (Deck *)createDeck; // abstract
@end

