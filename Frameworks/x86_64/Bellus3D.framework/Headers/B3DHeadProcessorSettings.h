//
//  B3DHeadProcessorSettings.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 30/01/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B3DHeadProcessorSettingsMeshResolution) {
  /// 64K triangles & 4096x4096 texture size.
  B3DHeadProcessorSettingsMeshResolutionStandard,
  /// 250K triangles & 4096x4096 texture size.
  B3DHeadProcessorSettingsMeshResolutionHigh,
  /// 8K triangles & 1024x1024 texture size.
  B3DHeadProcessorSettingsMeshResolutionLow
} NS_SWIFT_NAME(B3DHeadProcessorSettings.MeshResolution);

typedef NS_ENUM(NSInteger, B3DHeadProcessorSettingsMeshEnhancement) {
  B3DHeadProcessorSettingsMeshEnhancementNone,
  B3DHeadProcessorSettingsMeshEnhancementByColor,
  B3DHeadProcessorSettingsMeshEnhancementByLandmarks,
  B3DHeadProcessorSettingsMeshEnhancementByColorAndLandmarks
} NS_SWIFT_NAME(B3DHeadProcessorSettings.MeshEnhancement);

typedef NS_ENUM(NSInteger, B3DHeadProcessorMeshCoordinateUnit) {
  B3DHeadProcessorMeshCoordinateUnitCM,
  B3DHeadProcessorMeshCoordinateUnitMM
} NS_SWIFT_NAME(B3DHeadProcessorSettings.MeshCoordinateUnit);

/// Class represents settings of producing the head 3D model
OBJC_VISIBLE @interface B3DHeadProcessorSettings : NSObject

/// When processing finished the directory may contain internal service files related to the processing (logs etc)
@property (nonatomic, strong, nullable) NSURL *rootOutputDirectory;
@property (nonatomic, assign) B3DHeadProcessorSettingsMeshEnhancement meshEnhancement;
@property (nonatomic, assign) NSInteger meshSmoothness;

- (BOOL)loadDefaultSettingsWithError:(NSError ** _Nullable)outError;

@end

NS_ASSUME_NONNULL_END
