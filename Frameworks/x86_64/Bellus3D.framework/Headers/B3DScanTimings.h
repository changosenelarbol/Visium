//
//  B3DScanTimings.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 02/02/2021.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class B3DScanDirectionTimings;

OBJC_VISIBLE @interface B3DScanTimings : NSObject

- (instancetype)initWithTimeoutBeforeScan:(NSTimeInterval)timeoutBeforeScan
                           horizontalScan:(B3DScanDirectionTimings *)horizontalScan
                             verticalScan:(B3DScanDirectionTimings *)verticalScan;

@property (nonatomic, assign) NSTimeInterval timeoutBeforeScan;
@property (nonatomic, strong) B3DScanDirectionTimings *horizontalScan;
@property (nonatomic, strong, nullable) B3DScanDirectionTimings *verticalScan;

@end

NS_ASSUME_NONNULL_END
