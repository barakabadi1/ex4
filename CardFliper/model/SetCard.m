//
//  SetCard.m
//  CardFliper
//
//  Created by Barak Abadi on 23/11/2021.
//

#import "SetCard.h"

@implementation SetCard




- (int) match:(NSArray *)otherCards{
  
  int score = 0;
  if (otherCards.count != 2) {
    return score;
  }
  
  SetCard *card1 = [otherCards firstObject];
  SetCard *card2 = [otherCards lastObject];
  
  if ([self isFeatureAllowSetFeature1:[NSNumber numberWithUnsignedInteger:self.shape]
                             feature2:[NSNumber numberWithUnsignedInteger:card1.shape]
                            featuree3:[NSNumber numberWithUnsignedInteger:card2.shape]]) {
    score++;
  }else{
    return 0;
  }
  
  if ([self isFeatureAllowSetFeature1:[NSNumber numberWithUnsignedInteger:self.numOfSymbol]
                             feature2:[NSNumber numberWithUnsignedInteger:card1.numOfSymbol]
                            featuree3:[NSNumber numberWithUnsignedInteger:card2.numOfSymbol]]) {
    score++;
  }else{
    return 0;
  }
  
  if ([self isFeatureAllowSetFeature1:[NSNumber numberWithUnsignedInteger:self.color]
                             feature2:[NSNumber numberWithUnsignedInteger:card1.color]
                            featuree3:[NSNumber numberWithUnsignedInteger:card2.color]]) {
    score++;
  }else{
    return 0;
  }
  
  if ([self isFeatureAllowSetFeature1:[NSNumber numberWithUnsignedInteger:self.shading]
                             feature2:[NSNumber numberWithUnsignedInteger:card1.shading]
                            featuree3:[NSNumber numberWithUnsignedInteger:card2.shading]]) {
    score++;
  }else{
    return 0;
  }
  
  return score;
}


- (BOOL) isFeatureAllowSetFeature1:(NSNumber *)feature1 feature2:(NSNumber *)feature2 featuree3:(NSNumber *)feature3{
  NSUInteger setSize = [NSSet setWithArray:@[feature1,feature2,feature3]].count;
  return  setSize == 1 || setSize == 3;
}

@end
