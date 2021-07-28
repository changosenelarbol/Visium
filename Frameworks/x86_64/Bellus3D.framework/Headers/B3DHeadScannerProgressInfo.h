//
//  B3DHeadScannerProgressInfo.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 12/02/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(B3DHeadScanner.ProgressInfo)
OBJC_VISIBLE @interface B3DHeadScannerProgressInfo : NSObject

/// The largest left position head has reached during scan. Each coordinate gets values from range [-1; 0],
/// where -1 corresponds to leftmost/topmost position, 0 corresponds to central position.
@property (nonatomic, readonly) CGPoint maxReachedHeadPosition;

/// The largest right position head has reached during scan. Each coordinate gets values from range [0; 1],
/// where 1 corresponds to rightmost/bottommost position, 0 corresponds to central position.
@property (nonatomic, readonly) CGPoint minReachedHeadPosition;

/// Head position at what the head currently is. Each coordinate gets values from range [-1; 1],
/// where -1 corresponds to leftmost/topmost position, 0 corresponds to central position and
/// 1 corresponds to rightmost/bottommost position.
@property (nonatomic, readonly) CGPoint currentHeadPosition;

/// Guiding position that head should follow. Each coordinate takes values from range [0; 4].
/// Each value means the change of the the corresponding direction (vertical or horizontal) of rotation.
/// @discussion
/// Value changes as follows relatively to head position:
/// @code
/// (0,0) [look straight] -> (1,0)[leftmost] -> (2,0)[look straight] -> (3,0)[rightmost] -> (4,0)[look straight] -> (0,0)[look straight] -> (0,1)[topmost] -> (0,2)[look straight] -> (0,3)[bottommost] -> (0,4)[look straight]
/// @endcode
@property (nonatomic, readonly) CGPoint targetPosition;

/// Time in milliseconds left until the scan is finished.
@property (nonatomic, readonly) NSTimeInterval scanningTimeLeft;

@end

NS_ASSUME_NONNULL_END
