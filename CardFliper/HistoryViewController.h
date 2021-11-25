//
//  HistoryViewController.h
//  CardFliper
//
//  Created by Barak Abadi on 25/11/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController

@property (strong,nonatomic) NSMutableArray<NSAttributedString *> *actionHistory;
@property (strong,nonatomic) NSMutableArray<NSNumber *> *scoreHistory;

- (void)addActionToHistory:(NSAttributedString *)action withScore:(NSInteger)score;


@end

NS_ASSUME_NONNULL_END
