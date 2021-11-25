//
//  SetCard.h
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (nonatomic) NSUInteger shapeIndex;
@property (nonatomic) NSUInteger numOfSymbol;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shading;

- (NSString *)shape;
+ (NSArray *)shapeStrings;

@end

NS_ASSUME_NONNULL_END
