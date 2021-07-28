//
//  B3DHeadScanner.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 05/02/2018.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B3DHeadScannerState) {
  B3DHeadScannerStateIdle,
  B3DHeadScannerStatePreparing,
  B3DHeadScannerStateTracking,
  B3DHeadScannerStateScanning
} NS_SWIFT_NAME(B3DHeadScanner.State) API_AVAILABLE(ios(11.1));

typedef NS_CLOSED_ENUM(NSInteger, B3DHeadScannerFacePosition) {
  B3DHeadScannerFacePositionReadyToScan,
  B3DHeadScannerFacePositionFaceNotFound,
  B3DHeadScannerFacePositionFaceNotFrontal,
  B3DHeadScannerFacePositionFaceTooClose,
  B3DHeadScannerFacePositionFaceTooFar,
  B3DHeadScannerFacePositionFaceNotCentered,
  B3DHeadScannerFacePositionNotAvailable
} NS_SWIFT_NAME(B3DHeadScanner.FacePosition) API_AVAILABLE(ios(11.1));

typedef NS_CLOSED_ENUM(NSInteger, B3DHeadScannerScanHint) {
  B3DHeadScannerScanHintNone,
  B3DHeadScannerScanHintHoldStill,
  B3DHeadScannerScanHintCountdownThree,
  B3DHeadScannerScanHintCountdownTwo,
  B3DHeadScannerScanHintCountdownOne,
  B3DHeadScannerScanHintTurnHeadLeft,
  B3DHeadScannerScanHintKeepHeadTurning,
  B3DHeadScannerScanHintTurnHeadRight,
  B3DHeadScannerScanHintTurnHeadToTheMiddle,
  B3DHeadScannerScanHintTurnHeadUp,
  B3DHeadScannerScanHintTurnHeadDown,
  B3DHeadScannerScanHintCaptureCompleted,
  B3DHeadScannerScanHintCaptureAboutToStop
} NS_SWIFT_NAME(B3DHeadScanner.ScanHint) API_AVAILABLE(ios(11.1));

@class B3DHeadScannerSessionData, B3DHeadScannerSettings, B3DHeadScannerProgressInfo, B3DCamera, CALayer;
@protocol B3DHeadScannerObserver;

/// Uses stream from a specified camera object to scan series
/// of images that may be used to produce a 3D model of head.
/// For better scan quality before scan start analyses camera
/// stream to define if head position is appropriate.
API_AVAILABLE(ios(11.1))
OBJC_VISIBLE @interface B3DHeadScanner : NSObject

- (instancetype)initWithCamera:(B3DCamera *)camera;

/// Initializes object using queue that will be used to report observation methods with observers.
/// By default (using -initWithCamera:) uses main queue of the application.
- (instancetype)initWithCamera:(B3DCamera *)camera observerReportingQueue:(dispatch_queue_t)observerReportingQueue;

/// Returns if current device application is running on supports head scanning
@property (class, nonatomic, readonly) BOOL isSupported;

@property (nonatomic, readonly) B3DHeadScannerState state;
@property (nonatomic, strong) B3DHeadScannerSettings *settings;
@property (nullable, nonatomic, readonly) CALayer *previewLayer;

/// Tracking of head positioning 
- (void)startTracking;

/// Has to be called while tracking in progress.
- (void)startScanning;
- (void)cancel;

- (void)addObserver:(id<B3DHeadScannerObserver>)observer NS_SWIFT_NAME(addObserver(_:));
- (void)removeObserver:(id<B3DHeadScannerObserver>)observer NS_SWIFT_NAME(removeObserver(_:));

@end

API_AVAILABLE(ios(11.1))
OBJC_VISIBLE @protocol B3DHeadScannerObserver <NSObject>

@optional
/// Reports face position detected by scanner
- (void)headScanner:(B3DHeadScanner *)headScanner didTrackFacePosition:(B3DHeadScannerFacePosition)facePosition;

/// Called several times before scan actually starts to enable client to give user some time to prepare for start turning head.
- (void)headScanner:(B3DHeadScanner *)headScanner didReportCountdown:(float)countdown;

/// Called before scan started. Reports total duration of scan.
/// Guaranteed to be called before first hint related to scan process (head turn hint) is reported.
- (void)headScanner:(B3DHeadScanner *)headScanner willStartScanningWithDuration:(NSTimeInterval)scanDuration;

/// Called several times during scanning reporting current head position and desired head rotation velocity.
- (void)headScanner:(B3DHeadScanner *)headScanner didReportProgressInfo:(B3DHeadScannerProgressInfo *)progressInfo;

/// Called after cancelling scan when scan is stopping.
- (void)headScannerWillStopScanning:(B3DHeadScanner *)headScanner;

/// Called when scanning is completed.
/// @param resultingSessionData Contains session data referencing the scan results if scan succeeded. Otherwise the parameter is nil.
- (void)headScanner:(B3DHeadScanner *)headScanner
    didCompleteScanningSuccessfully:(BOOL)completedSuccessfully
    resultingSessionData:(nullable B3DHeadScannerSessionData *)resultingSessionData;

/// Called when tracking is failing.
- (void)headScanner:(B3DHeadScanner *)headScanner trackingDidFailWithError:(nullable NSError *)error;

/// Called at each key point of scanning (countdown, changing of rotation direction of head, capture completion etc)
/// to provide the appropriate point in code that may be used by client to present the corresponding UI with hint or play sound
- (void)headScanner:(B3DHeadScanner *)headScanner didProvideHint:(B3DHeadScannerScanHint)hint;

/// May be called several times during processing to report occurred errors. There is no direct connection between this errors and completion
/// success. That is, scanning may succeed even if some errors occurred. And vice versa: scanning may fail even if there was no error.
- (void)headScanner:(B3DHeadScanner *)headScanner didEncounterError:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
