//
//  B3DPoint2D.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 18/6/18.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE @interface B3DPoint2D : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) float x;
@property (nonatomic, readonly) float y;

- (instancetype)initWithX:(float)x y:(float)y;

@end

NS_ASSUME_NONNULL_END
