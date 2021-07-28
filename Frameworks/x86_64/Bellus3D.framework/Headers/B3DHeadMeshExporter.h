//
//  B3DMeshExporter.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 20/11/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Bellus3D/B3DHeadProcessorSettings.h>

@class B3DPoint2D;
@class B3DPoint3D;
@class UIColor;

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, B3DHeadMeshExporterEarLandmarkComponents) {
  B3DHeadMeshExporterEarLandmarkComponentsLeft,
  B3DHeadMeshExporterEarLandmarkComponentsRight,
  B3DHeadMeshExporterEarLandmarkComponentsBoth
} NS_SWIFT_NAME(B3DHeadMeshExporter.EarLandmarkComponents);

OBJC_VISIBLE extern NSString *const B3DHeadMesh2DLandmarkDataKey;
OBJC_VISIBLE extern NSString *const B3DHeadMesh3DLandmarkDataKey;
OBJC_VISIBLE extern NSString *const B3DHeadMesh2DEarLandmarkDataKey;
OBJC_VISIBLE extern NSString *const B3DHeadMesh3DEarLandmarkDataKey;

typedef NSDictionary<NSString *, NSArray *> *LandmarkData;

OBJC_VISIBLE @interface B3DHeadMeshExporter : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign) B3DHeadProcessorSettingsMeshResolution meshResolution;

/// Export the mesh files with texture map to the specified directoryURL.
/// @note The number of vertices in the mesh is controlled by @c setMeshResolution.
/// @note Extension specified in file name determines export file type. Currently, the following are supported:
/// @c.obj, @c.glb, @c.stl, @c.zip (will produce @c.obj along with texture and calibration packed in zip archive),
/// @c.ply, @c.ply.zip (will produce @c.ply with supporting files packed in zip archive).
/// For @c.obj file texture map and mtl file will be generated and use the same name as fileName but with different file extensions (jpg and mtl).
/// @param[in] directoryURL Directory where to generate file.
/// @param[in] filename Name of file with extension.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)exportMeshFilesToDirectoryAtURL:(NSURL *)directoryURL filename:(NSString *)filename error:(NSError ** _Nullable)error;

/// Returns a dictionary containing landmark data.
/// @note In the returned dictionary value for key @c B3DHeadMesh2DLandmarkDataKey contains 2D landmarks represented by array of @c B3DPoint2D point objects.
/// @note Value for key @c B3DHeadMesh3DLandmarkDataKey contains 3D landmarks represented by array of @c B3DPoint3D point objects.
/// @param[in] isInOBJFileSpace If YES is specified the 3d landmarks will be transformed to match the head's OBJ file space.
/// @param[in] useOriginalTextureSize If YES is specified the 2d landmarks will match the original texture map size. Otherwise it matches the output texture map coordinate space
/// @returns Dictionary containing 2D landmarks and 3D landmarks.
- (LandmarkData)landmarkDataWithOBJFileSpace:(BOOL)isInOBJFileSpace
                      useOriginalTextureSize:(BOOL)useOriginalTextureSize NS_SWIFT_NAME(landmarkData(objFileSpace:useOriginalTextureSize:));

/// Returns a dictionary containing landmark data
/// with isInOBJFileSpace set to YES and useOriginalTextureSize set to NO.
- (LandmarkData)landmarkData;

/// Returns a dictionary containing ear landmark data.
/// @note In the returned dictionary value for key @c B3DHeadMesh2DEarLandmarkDataKey contains 2D ear landmarks represented by array of @c B3DPoint2D point objects.
/// @note Value for key @c B3DHeadMesh3DEarLandmarkDataKey contains 3D ear landmarks represented by array of @c B3DPoint3D point objects.
/// @param isInOBJFileSpace If parameter is true, the 3D landmarks will be transformed to match the head's OBJ file space, where the origin is the center of the head. Otherwise the 3D landmarks will point in the world space where if is relative to the L camera (origin)
/// @param useOriginalTextureSize  If parameter is true, the 2D landmarks match the original texture map size. Otherwise they match the output texture map coordinate space. (originalTextureSize is true)
/// @param[out] error Optional error object.
/// @returns Dictionary containing 2D ear landmarks and 3D ear landmarks.
- (nullable LandmarkData)detectEarLandmarksWithOBJFileSpace:(BOOL)isInOBJFileSpace
                                     useOriginalTextureSize:(BOOL)useOriginalTextureSize
                                            coordinateUnits:(int)coordinateUnits
                                           outputComponents:(nullable B3DHeadMeshExporterEarLandmarkComponents *)outputComponents
                                                      error:(NSError ** _Nullable)error
    NS_SWIFT_NAME(detectEarLandmarks(objFileSpace:useOriginalTextureSize:coordinateUnits:outputComponents:));

- (nullable LandmarkData)detectEarLandmarksWithOBJFileSpace:(BOOL)isInOBJFileSpace
                                     useOriginalTextureSize:(BOOL)useOriginalTextureSize
                                           outputComponents:(nullable B3DHeadMeshExporterEarLandmarkComponents *)outputComponents
                                                      error:(NSError ** _Nullable)error
    NS_SWIFT_NAME(detectEarLandmarks(objFileSpace:useOriginalTextureSize:coordinateUnits:));

- (nullable LandmarkData)detectEarLandmarksWithOutputComponents:(nullable B3DHeadMeshExporterEarLandmarkComponents *)outputComponents
                                                          error:(NSError ** _Nullable)error
                                           NS_SWIFT_NAME(detectEarLandmarks(outputComponents:));

/// Returns a dictionary containing ear landmark data.
/// @note In the returned dictionary value for key @c B3DHeadMesh2DEarLandmarkDataKey contains 2D ear landmarks represented by array of @c B3DPoint2D point objects.
/// @note Value for key @c B3DHeadMesh3DEarLandmarkDataKey contains 3D ear landmarks represented by array of @c B3DPoint3D point objects.
/// @param[out] error Optional error object.
/// @returns Dictionary containing 2D ear landmarks and 3D ear landmarks.
- (nullable LandmarkData)detectEarLandmarkDataWithError:(NSError ** _Nullable)error;

/// Returns 3D landmarks for provided 2D landmarks detected on texture.
/// @note The 2D landmarks should match the texture map coordinate space.
/// @note The 3D landmarks should be points in the world space where if is relative to the L camera (origin).
/// @param[in] landmarks2d 2D landmarks detected on texture using custom facial detection.
/// @param[in] textureSize Size of the texture on which 2D landmarks were detected.
/// @param[in] fileURL Path to .yml file to which 3D landmarks should be written.
/// @param[out] error Optional error object.
/// @returns Array containing 3D landmarks or nil in case of error.
- (nullable NSArray<B3DPoint3D *> *)landmarks3DFrom2D:(NSArray<B3DPoint2D *> *)landmarks2d
                                          textureSize:(CGSize)textureSize
                                              fileURL:(nullable NSURL *)fileURL
                                                error:(NSError ** _Nullable)error;

/// Write landmark data to file at specified URL.
/// @note The 2D landmarks should match the texture map coordinate space.
/// @note The 3D landmarks should be points in the world space where if is relative to the L camera (origin).
/// @param[in] fileURL Path to .yml file to which 3D landmarks should be written.
/// @param[in] inModelFileCoordinateSpace If YES is specified, the 3D landmarks will be transformed to match the head's OBJ file space, where the origin is the center of the head.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)writeLandmarksToFileAtURL:(NSURL *)fileURL
       inModelFileCoordinateSpace:(BOOL)inModelFileCoordinateSpace
                            error:(NSError ** _Nullable)error;

/// Write landmark data along with the head's OBJ file to a directory at specified URL.
/// @note Landmark data matches the head's OBJ file space, where the origin is the center of the head.
/// @note The 2D landmarks should match the texture map coordinate space.
/// @note The 3D landmarks should be points in the world space where if is relative to the L camera (origin).
/// @param[in] directoryURL URL of directory where the data should be written.
/// @param[in] landmarksDataFileName Filename of the landmark data file to be generated.
/// @param[in] modelFileName Filename of the OBJ file to be generated.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)writeLandmarksToDirectoryAtURL:(NSURL *)directoryURL
                 landmarksDataFileName:(NSString *)landmarksDataFileName
                         modelFileName:(NSString *)modelFileName
                                 error:(NSError ** _Nullable)error;

/// Write ear landmark data to file at specified URL.
/// @note The 2D landmarks should match the texture map coordinate space.
/// @note The 3D landmarks should be points in the world space where if is relative to the L camera (origin).
/// @param[in] fileURL Path to .yml file to which 3D landmarks should be written.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)detectAndWriteEarLandmarksToFileAtURL:(NSURL *)fileURL
                                        error:(NSError ** _Nullable)error;

/// Write ear landmark data along with the head's OBJ file to a directory at specified URL.
/// @note The 2D landmarks should match the texture map coordinate space.
/// @note The 3D landmarks should be points in the world space where if is relative to the L camera (origin).
/// @param[in] directoryURL URL of directory where the data should be written.
/// @param[in] landmarksDataFileName Filename of the landmark data file to be generated.
/// @param[in] modelFileName Filename of the OBJ file to be generated.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)detectAndWriteEarLandmarksToDirectoryAtURL:(NSURL *)directoryURL
                             landmarksDataFileName:(NSString *)landmarksDataFileName
                                     modelFileName:(NSString *)modelFileName
                                             error:(NSError ** _Nullable)error;

/// Exports all photo views as .jpeg images to a .zip file.
/// @note The images will be named as "photo_c0.jpg", "photo_l1.jpg", "photo_l2.jpg", etc.
/// @param[in] fileURL URL to the output .zip file.
/// @param[in] addViewer If set to YES html slide viewer will be created in the same directory to browse the images.
/// @param[in] captionText Optional title text in the viewer and is only used if addViewer is YES.
/// @param[out] error Optional error object.
/// @returns YES in case of success.
- (BOOL)exportPhotoViewsToFileAtURL:(NSURL *)fileURL
                          addViewer:(BOOL)addViewer
                        captionText:(nullable NSString *)captionText
                              error:(NSError ** _Nullable)error;



@end

NS_ASSUME_NONNULL_END
