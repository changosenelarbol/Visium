//
//  B3DMaterialSettings+SceneKitExtension.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 29/08/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Bellus3D/B3DMaterialSettings.h>
#import <Foundation/Foundation.h>
#import <SceneKit/SceneKitTypes.h>

OBJC_VISIBLE @interface B3DMaterialSettings (SceneKitExtension)

/// This should be applied to texture before rendering using SceneKit
/// to adjust coordinate system of texture to the one of Scenekit
@property (nonatomic, readonly) SCNMatrix4 textureTransform;

@end
