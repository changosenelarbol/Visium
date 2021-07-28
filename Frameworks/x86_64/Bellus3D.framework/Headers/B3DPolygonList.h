//
//  B3DMeshPolygons.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 11/06/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bellus3D/B3DVertex.h>

NS_ASSUME_NONNULL_BEGIN

extern const int B3DPolygonListVertexCountPerPolygon;
extern const int B3DPolygonListColorCompomnentCount;

OBJC_VISIBLE @interface B3DPolygonList : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) NSUInteger numberOfComponentsInVertex;
@property (nonatomic, readonly) NSUInteger vertexCount;
@property (nonatomic, readonly) NSUInteger positionCount;
@property (nonatomic, readonly) NSUInteger triangleCount;

/// Iterates over triangles returning vertices for each triangle. Each vertex color is valid only if polygon list has vertex colors
- (void)enumerateTrianglesUsingBlock:(void(^ NS_NOESCAPE)(B3DVertex first, B3DVertex second, B3DVertex third))enumerationBlock;

- (NSUInteger)getVertices:(float *)outVertices bufferElementCount:(NSUInteger)count;
- (NSUInteger)getVertexColors:(UInt8 *)outVertices bufferElementCount:(NSUInteger)count;
- (NSUInteger)getVertexCoordinatePositions:(int *)outVertexCoordinatePositions bufferElementCount:(NSUInteger)count;
- (NSUInteger)getVertexNormalPositions:(int *)outVertexNormalPositions bufferElementCount:(NSUInteger)count;
- (NSUInteger)getVertexTextureCoordinatePositions:(int *)outVertexTextureCoordinatePositions bufferElementCount:(NSUInteger)count;

- (NSData *)verticesData;
/// Returns empty data if polygon list does not contain vertex colors
- (NSData *)verticesColorData;
- (NSData *)vertexCoordinatePositionData;
- (NSData *)vertexNormalPositionData;
- (NSData *)vertexTextureCoordinatePositionData;

@end

NS_ASSUME_NONNULL_END
