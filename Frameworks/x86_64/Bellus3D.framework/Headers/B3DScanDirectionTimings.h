//
//  B3DScanDirectionTimings.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 02/02/2021.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE @interface B3DScanDirectionTimings : NSObject

@property (nonatomic, assign) NSTimeInterval centerToFirstPositionTurn;
@property (nonatomic, assign) NSTimeInterval delayAtFirstPosition;
@property (nonatomic, assign) NSTimeInterval firstToSecondPositionTurn;
@property (nonatomic, assign) NSTimeInterval delayAtSecondPosition;
@property (nonatomic, assign) NSTimeInterval secondPositionToCenterTurn;

- (instancetype)initWithCenterToFirstPositionTurn:(NSTimeInterval)centerToFirstPositionTurn
                             delayAtFirstPosition:(NSTimeInterval)delayAtFirstPosition
                        firstToSecondPositionTurn:(NSTimeInterval)firstToSecondPositionTurn
                            delayAtSecondPosition:(NSTimeInterval)delayAtSecondPosition
                       secondPositionToCenterTurn:(NSTimeInterval)secondPositionToCenterTurn;

@end

NS_ASSUME_NONNULL_END
