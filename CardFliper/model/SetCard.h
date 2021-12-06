//
//  SetCard.h
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

// shape strings
- (NSString *)shape;

// array of shapes
+ (NSArray *)shapeStrings;

// the shape index
@property (nonatomic) NSUInteger shapeIndex;

// the symbol index
@property (nonatomic) NSUInteger numOfSymbol;

// the color index
@property (nonatomic) NSUInteger color;

//the shading index
@property (nonatomic) NSUInteger shading;


@end

NS_ASSUME_NONNULL_END
