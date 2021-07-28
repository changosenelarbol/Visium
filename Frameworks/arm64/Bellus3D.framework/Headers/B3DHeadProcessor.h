//
//  B3DHeadProcessor.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 30/01/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol B3DHeadProcessorObserver;
@class B3DHeadProcessorSettings, B3DHeadScannerSessionData, B3DHeadMesh;

/// Class is intended to produce 3D model of head using series of scanned images containing
/// depth and color information.
OBJC_VISIBLE @interface B3DHeadProcessor : NSObject

/// Initializes object using queue that will be used to report observation methods with observers.
/// By default (using -init) uses main queue of the application.
- (instancetype)initWithObserverReportingQueue:(dispatch_queue_t)observerReportingQueue;

/// Returns whether texture watermark is enabled.
@property (nonatomic, readonly) BOOL isWatermarkEnabled;

/// Settings used during 3D model generation.
@property (nonatomic, strong) B3DHeadProcessorSettings *settings;

- (void)addObserver:(id<B3DHeadProcessorObserver>)observer NS_SWIFT_NAME(addObserver(_:));
- (void)removeObserver:(id<B3DHeadProcessorObserver>)observer NS_SWIFT_NAME(removeObserver(_:));

/// Starts asynchronous processing using specified session data.
/// The processing flow status will be reported via observers.
- (void)startProcessingWithSessionData:(B3DHeadScannerSessionData *)sessionData;

/// Performs synchronous processing using specified session data.
- (void)processWithSessionData:(B3DHeadScannerSessionData *)sessionData;

- (void)cancelProcessing;

@end

OBJC_VISIBLE @protocol B3DHeadProcessorObserver<NSObject>
@optional

- (void)headProcessor:(B3DHeadProcessor *)headProcessor didReportProgress:(float)progress;
- (void)headProcessor:(B3DHeadProcessor *)headProcessor didCompleteProcessingWithMesh:(nullable B3DHeadMesh *)headMesh;

/// May be called several times during processing to report occured errors. There is no direct connection between this errors and completion
/// success. That is, processing may succeed even if some errors occurred. And vice versa: processing may fail even if there were no errors.
- (void)headProcessor:(B3DHeadProcessor *)headProcessor didEncounterError:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
