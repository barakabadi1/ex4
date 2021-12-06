//
//  SetCardView.h
//  CardFliper
//
//  Created by Barak Abadi on 06/12/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

@property (nonatomic) NSUInteger shapeIndex;
@property (nonatomic) NSUInteger numOfSymbol;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shading;

@property (nonatomic) BOOL faceUp;


@end

NS_ASSUME_NONNULL_END
