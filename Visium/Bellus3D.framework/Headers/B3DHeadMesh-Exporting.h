//
//  B3DHeadMesh-Exporting.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 20/11/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Bellus3D/B3DHeadMesh.h>

@class B3DModelInfo;
@class B3DHeadMeshExporter;
@protocol B3DHeadMeshBySharingActivationObserver;

NS_ASSUME_NONNULL_BEGIN

/// List of available activation methods.
typedef NS_ENUM(NSInteger, B3DHeadMeshPremiumFeatureActivationMethod) {
  /// Activate export by sharing a copy of the head mesh to Bellus3D.
  B3DHeadMeshPremiumFeatureActivationMethodBySharing,
  /// Activate export by requesting token from server.
  B3DHeadMeshPremiumFeatureActivationMethodByToken
} NS_SWIFT_NAME(B3DHeadMesh.PremiumFeatureActivationMethod);

OBJC_VISIBLE @interface B3DHeadMesh (Exporting)

/// Returns whether activation by sharing is available on current device.
@property (class, nonatomic, readonly) BOOL isActivationBySharingAvailable;

/// Returns number of tokens required for model activation on current device.
@property (class, nonatomic, readonly) NSUInteger numberOfTokensRequiredForModelActivation;

/// Returns number of tokens currently available on device in local cache.
/// Returns nil if the local storage cache is not available, e.g. when SDK is not initialized.
@property (class, readonly, nullable) NSNumber *numberOfCachedTokens NS_REFINED_FOR_SWIFT;

/// Method is used to obtain object that provides access to premium features.
/// Only authenticated clients can use that functionality.
/// Pass the desired activation method as @c activationMethod parameter
/// In case the activation method is "by sharing" you may also pass an optional model informations.
- (void)requestActivationOfPremiumFeaturesWithModelInfo:(nullable B3DModelInfo *)modelInfo
                                       activationMethod:(B3DHeadMeshPremiumFeatureActivationMethod)activationMethod
                                      completionHandler:(void(^)(B3DHeadMeshExporter * _Nullable, NSError * _Nullable))completionHandler;

/// Export the mesh to .glb file at specified fileURL.
/// File should have .glb extension.
- (BOOL)exportMeshToGLBFileAtURL:(NSURL *)fileURL error:(NSError ** _Nullable)error;

- (void)addObserver:(id<B3DHeadMeshBySharingActivationObserver>)observer;
- (void)removeObserver:(id<B3DHeadMeshBySharingActivationObserver>)observer;

@end

#pragma mark - B3DHeadMeshObserver

/// Receives notifications related to B3DHeadMeshPremiumFeatureActivationMethodBySharing activation method
OBJC_VISIBLE @protocol B3DHeadMeshBySharingActivationObserver <NSObject>

@optional

/// Notifies that model upload succeeded.
- (void)headMesh:(B3DHeadMesh *)headMesh
  didCompleteModelUploadWithModelID:(NSString *)modelID
  modelInfo:(B3DModelInfo *)modelInfo;

/// Notifies that model upload failed.
- (void)headMesh:(B3DHeadMesh *)headMesh
  didFailToUploadModelWithModelInfo:(B3DModelInfo *)modelInfo
  error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
