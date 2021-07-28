//
//  B3DPolygonList-SceneKitExtension.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 29/06/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bellus3D/B3DPolygonList.h>

@class MDLMesh;
@class SCNGeometry;

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE @interface B3DPolygonList (SceneKit)

- (MDLMesh *)modelMesh;
- (SCNGeometry *)makeGeometry;

@end

NS_ASSUME_NONNULL_END
