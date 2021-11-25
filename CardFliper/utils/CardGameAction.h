//
//  CardGameAction.h
//  CardFliper
//
//  Created by Barak Abadi on 25/11/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardGameAction : NSObject

@property (strong,readonly,nonatomic) NSString *action;
@property (strong,readonly,nonatomic) NSArray *cards;
@property (readonly,nonatomic) NSInteger score;

- (instancetype)initWithAction:(NSString *)action andCards:(NSArray *)cards andScore:(NSInteger)score;

- (NSAttributedString *)attributeDescription;

@end

NS_ASSUME_NONNULL_END
