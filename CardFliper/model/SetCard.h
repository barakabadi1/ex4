//
//  SetCard.h
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger numOfSymbol;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shading;

@end

NS_ASSUME_NONNULL_END
