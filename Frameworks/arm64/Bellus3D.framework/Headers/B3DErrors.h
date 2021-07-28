//
//  B3DErrors.h
//  Bellus3D-Device
//
//  Created by Andrii Biehunov on 30/01/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE extern NSString *const B3DErrorDomain;

typedef NS_ERROR_ENUM(B3DErrorDomain, B3DErrorCode) {
  B3DErrorCodeNoError                         = 0,
  B3DErrorCodeCanceled                        = 1,
  B3DErrorCodeNotInitialized                  = 2,
  B3DErrorCodeAlreadyInitialized              = 3,
  B3DErrorCodeAuthenticationFailed            = 4,
  B3DErrorCodeUnauthorized                    = 5,
  B3DErrorCodeDepthCameraDisconnected         = 6,
  B3DErrorCodeDepthCameraOperationError       = 7,
  B3DErrorCodeDepthCameraStreamError          = 8,
  B3DErrorCodeAccessToCameraNotGranted        = 9,
  B3DErrorCodeFaceTrackingDetectionError      = 10,
  B3DErrorCodeFaceTrackingTimeout             = 11,
  B3DErrorCodeFileIOError                     = 12,
  B3DErrorCodeFileMissing                     = 13,
  B3DErrorCodeImageConversionError            = 14,
  B3DErrorCodeInternalLibraryError            = 15,
  B3DErrorCodeInternalStreamingError          = 16,
  B3DErrorCodeInvalidDepthCamera              = 17,
  B3DErrorCodeInvalidDeviceCamera             = 18,
  B3DErrorCodeInvalidFileURL                  = 19,
  B3DErrorCodeInvalidInput                    = 20,
  B3DErrorCodeInvalidOutput                   = 21,
  B3DErrorCodeInvalidSessionData              = 22,
  B3DErrorCodeInvalidState                    = 23,
  B3DErrorCodeMeshBuildError                  = 24,
  B3DErrorCodeMeshBuildCanceled               = 25,
  B3DErrorCodeMeshBuildInputError             = 26,
  B3DErrorCodeMeshBuildFaceDetectionError     = 27,
  B3DErrorCodeMeshBuildScanRangeError         = 28,
  B3DErrorCodeMeshBuildTrackingError          = 29,
  B3DErrorCodeMeshBuildOutputError            = 30,
  B3DErrorCodeMeshBuildUnknownError           = 31,
  B3DErrorCodePreviewGenerationError          = 32,
  B3DErrorCodeRecalibrationError              = 33,
  B3DErrorCodeSessionDataCreationError        = 34,
  B3DErrorCodeInvalidExportActivationMethod   = 35,
  B3DErrorCodeExportActivationFailed          = 36,
  B3DErrorCodeOtherExportActivationInProgress = 37,
  B3DErrorCodeServerRequestFailed             = 38,
  B3DErrorCodeEmptyCredentials                = 39,
  B3DErrorCodeLicenseExpired                  = 40,
  B3DErrorCodeObjectCreationFailed            = 41,
  B3DErrorCodeObjectNotFound                  = 42,
  B3DErrorCodeObjectSerializationFailed       = 43,
  B3DErrorCodeObjectDeserializationFailed     = 44,
  B3DErrorCodeMeshSimplificationError         = 45,
  B3DErrorCodeInternalInitializationError     = 46,
  B3DErrorCodeMeshCannotReadFile              = 47,
  B3DErrorCodeMeshCannotWriteFile             = 48,
  B3DErrorCodeCannotMeshFromTemplate          = 49,
  B3DErrorCodeAlphaComputationError           = 50,
  B3DErrorCodeCannotLoadParametersTemplate    = 51,
  B3DErrorCodeModelMorphingError              = 52,
  B3DErrorCodeFullHeadError                   = 53,
  B3DErrorCodeLeftEarRectError                = 54,
  B3DErrorCodeRightEarRectError               = 55,
  B3DErrorCodeFaceLMSError                    = 56,
  B3DErrorCodeEarLMSError                     = 57,
  B3DErrorCodeEmptyMesh                       = 58,
  B3DErrorCodeUnknown                         = 1000
};

OBJC_EXPORT NSString* B3DErrorLocalizedDescriptionWithCode(B3DErrorCode code) NS_SWIFT_NAME(B3DErrorLocalizedDescription(code:));

NS_ASSUME_NONNULL_END
