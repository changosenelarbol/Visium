//
//  B3DHeadMesh-Rendering.h
//  Bellus3D-PublicDistribution
//
//  Created by Andrii Biehunov on 06/02/2019.
//  Copyright © 2019 Bellus3D, Inc. All rights reserved.
//

#import <Bellus3D/B3DHeadMesh.h>

NS_ASSUME_NONNULL_BEGIN

@interface B3DHeadMesh (Rendering)

/// Returns polygon list object that represents mesh. The object may be used for generating different mesh
/// representations for rendering. By default returns mesh in low resolution. To change the resolution
/// set the corresponding @c meshResolution value on the @c B3DHeadMeshExporter object obtained by activating Premium Features
- (nullable B3DPolygonList *)polygonListReturningError:(NSError ** _Nullable)error NS_SWIFT_NAME(polygonList());

/// Returns texture for the mesh rendering. By default returns mesh in low resolution. To change the resolution
/// set the corresponding @c meshResolution value on the @c B3DHeadMeshExporter object obtained by activating Premium Features
- (nullable CGImageRef)texture CF_RETURNS_RETAINED;

@end

NS_ASSUME_NONNULL_END
