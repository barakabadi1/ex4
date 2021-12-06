//
//  SetCardView.h
//  CardFliper
//
//  Created by Barak Abadi on 06/12/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

// the shape index
@property (nonatomic) NSUInteger shapeIndex;

// the number of symbols
@property (nonatomic) NSUInteger numOfSymbol;

// the color index
@property (nonatomic) NSUInteger color;

// the shading index
@property (nonatomic) NSUInteger shading;

// mark if the card face up
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
