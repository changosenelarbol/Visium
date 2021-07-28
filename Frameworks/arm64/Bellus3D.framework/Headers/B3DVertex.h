//
//  B3DVertex.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 18/6/18.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Bellus3D/B3DVector.h>
#import <CoreGraphics/CoreGraphics.h>

typedef struct __B3DVertex {
  B3DVector coordinate;
  B3DVector normal;
  /// Vertex color in RGB color space. To get a particular color use B3DVertex<Component>ColorIndex constants
  UInt8 colorComponents[3];
  float u;
  float v;
} B3DVertex;

extern const unsigned B3DVertexRedColorIndex;
extern const unsigned B3DVertexGreenColorIndex;
extern const unsigned B3DVertexBlueColorIndex;
