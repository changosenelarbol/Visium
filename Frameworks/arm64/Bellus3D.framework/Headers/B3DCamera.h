//
//  B3DCamera.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 16/02/2018.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CALayer;
@protocol B3DCameraObserver, B3DCameraDelegate;

typedef NS_ENUM(NSInteger, B3DCameraVideoOrientation) {
  B3DCameraVideoOrientationPortrait,
  B3DCameraVideoOrientationPortraitUpsideDown,
  B3DCameraVideoOrientationLandscapeLeft,
  B3DCameraVideoOrientationLandscapeRight
} NS_SWIFT_NAME(B3DCamera.VideoOrientation) API_AVAILABLE(ios(11.1));

API_AVAILABLE(ios(11.1))
OBJC_VISIBLE @interface B3DCamera : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithVideoOrientation:(B3DCameraVideoOrientation)orientation;
- (instancetype)initWithVideoOrientation:(B3DCameraVideoOrientation)orientation
                 observerReportingQueue:(dispatch_queue_t)observerReportingQueue;

/// Returns if current device application is running on supports
/// retrieving depth data for streaming frames
@property (class, nonatomic, readonly) BOOL supportsDepthDataCapturing;
@property (nullable, nonatomic, readonly) CALayer *previewLayer;
@property (nonatomic, weak, nullable) id<B3DCameraDelegate> delegate;

/// Starts camera streaming. If streaming is already started has no effect.
/// Will ask for camera permission if no permission granted.
/// In case user grants permissions notifies observers about streaming started.
/// Otherwise notifies about error occurred.
- (void)startStreaming;

/// Stops camera streaming. If camera is not streaming has no effect.
- (void)stopStreaming;

/// Turns on automatic adjustment of picture control (white balance, exposure)
- (void)enableAutoPictureControlAdjustment;

/// Turns off automatic adjustment of picture control (white balance, exposure).
- (void)disableAutoPictureControlAdjustment;

- (void)addObserver:(id<B3DCameraObserver>)observer NS_SWIFT_NAME(addObserver(_:));
- (void)removeObserver:(id<B3DCameraObserver>)observer NS_SWIFT_NAME(removeObserver(_:));

@end

API_AVAILABLE(ios(11.1))
OBJC_VISIBLE @protocol B3DCameraObserver <NSObject>
@optional

/// Called when camera starts streaming
- (void)cameraDidStartStreaming:(B3DCamera *)camera;

/// Called when a session is interrupted. A camera streaming will be interrupted
/// and no longer able to track when it fails to receive required sensor data.
/// This happens when video capture is interrupted, for example when
/// the application is sent to the background or when there are multiple foreground
/// applications. No additional frame updates will be delivered
/// until the interruption has ended.
- (void)cameraDidStartInterruption:(B3DCamera *)camera;

/// Called when interruption ended and camera resumes streaming
- (void)cameraDidEndInterruption:(B3DCamera *)camera;

/// Called when camera stops streaming due to error
- (void)camera:(B3DCamera *)camera didFailWithError:(NSError *)error;

@end

API_AVAILABLE(ios(11.1))
OBJC_VISIBLE @protocol B3DCameraDelegate <NSObject>

/// Implementing object should return whether the streaming camera frames should be considered as the ones
/// that are actually used for image processing analysis.
/// If not implemented the default value is NO.
- (BOOL)framesAreConsumedForCamera:(B3DCamera *)camera;
- (BOOL)shouldDeliverFramesForCamera:(B3DCamera *)camera;

@end

NS_ASSUME_NONNULL_END
