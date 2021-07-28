//
//  B3DHeadMesh.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 11/06/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Bellus3D/B3DHeadProcessorSettings.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, B3DHeadMeshType) {
  /// Frontal part of head only
  B3DHeadMeshTypeFrontal,
  /// Frontal part of head with neck
  B3DHeadMeshTypeFrontalExtended,
  /// Full head mesh with short neck
  B3DHeadMeshTypeFullHead
} NS_SWIFT_NAME(B3DHeadMesh.MeshType);

@class B3DPolygonList;
@class B3DMaterialSettings;

OBJC_VISIBLE @interface B3DHeadMesh : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) B3DHeadMeshType meshType;

/// If the mesh type is @c B3DHeadMeshTypeFullHead when generating the mesh files/mesh data
/// the property defines whether or not the resulting mesh should be watertight.
/// For mesh types other than @c B3DHeadMeshTypeFullHead this property has no effect
@property (nonatomic, assign) BOOL shouldGenerateWatertightMesh;
@property (nonatomic, assign) B3DHeadProcessorMeshCoordinateUnit meshCoordinateUnit;
@property (nonatomic, readonly) BOOL isEmpty;

#pragma mark - Image data

- (nullable CGImageRef)frontalImage CF_RETURNS_RETAINED;
- (nullable CGImageRef)previewImage CF_RETURNS_RETAINED;

/// Represents preferred settings of the material of mesh. Client may be apply them to model during rendering.
+ (B3DMaterialSettings *)preferredMaterialSettings;

#pragma mark -
- (void)clear;

@end

NS_ASSUME_NONNULL_END
