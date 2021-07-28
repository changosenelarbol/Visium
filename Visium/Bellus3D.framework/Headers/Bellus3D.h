//
//  Bellus3D.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 29/01/2018.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

#import <Bellus3D/B3DVersion.h>
#import <Bellus3D/B3DEnvironment.h>
#import <Bellus3D/B3DAuthenticationManager.h>
#import <Bellus3D/B3DCamera.h>
#import <Bellus3D/B3DCredentials.h>
#import <Bellus3D/B3DErrors.h>
#import <Bellus3D/B3DHeadMesh-Exporting.h>
#import <Bellus3D/B3DHeadMesh-Rendering.h>
#import <Bellus3D/B3DHeadMesh.h>
#import <Bellus3D/B3DHeadMeshExporter.h>
#import <Bellus3D/B3DHeadProcessor.h>
#import <Bellus3D/B3DHeadProcessorSettings.h>
#import <Bellus3D/B3DHeadScanner.h>
#import <Bellus3D/B3DHeadScannerProgressInfo.h>
#import <Bellus3D/B3DHeadScannerSessionData.h>
#import <Bellus3D/B3DScanTimings.h>
#import <Bellus3D/B3DScanDirectionTimings.h>
#import <Bellus3D/B3DHeadScannerSettings.h>
#import <Bellus3D/B3DLogger.h>
#import <Bellus3D/B3DMaterialSettings-SceneKitExtension.h>
#import <Bellus3D/B3DMaterialSettings.h>
#import <Bellus3D/B3DModelInfo.h>
#import <Bellus3D/B3DPoint2D.h>
#import <Bellus3D/B3DPoint3D.h>
#import <Bellus3D/B3DPolygonList-SceneKitExtension.h>
#import <Bellus3D/B3DPolygonList.h>
#import <Bellus3D/B3DUserInfo.h>
#import <Bellus3D/B3DVector.h>
#import <Bellus3D/B3DVertex.h>

// We need to keep those classes in the public API due to interaction with swift code.
#import <Bellus3D/B3DAccessToken.h>
#import <Bellus3D/B3DClient.h>
