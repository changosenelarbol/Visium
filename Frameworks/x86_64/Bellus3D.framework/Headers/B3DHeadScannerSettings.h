//
//  B3DHeadScannerSettings.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 07/02/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, B3DHeadScannerSettingsScanMode) {
  B3DHeadScannerSettingsScanMode180Degrees, ///< Scanning approximately 180 degrees of a head
  B3DHeadScannerSettingsScanMode270Degrees, ///< Scanning approximately 270 degrees of a head
  B3DHeadScannerSettingsScanMode270DegreesLongScan, ///< Scanning approximately 270 degrees of a head with longer time to allow user to have more time to scan
  B3DHeadScannerSettingsScanMode360Degrees ///< Full Head Scanning
} NS_SWIFT_NAME(B3DHeadScannerSettings.ScanMode);

@class B3DScanTimings;

/// Class represents settings of head scanning
OBJC_VISIBLE @interface B3DHeadScannerSettings : NSObject

/// Directory that will be used for output of head scanner.
/// Setting nil will reset to temporary directory that will be created.
/// May return nil in case of some issue with creating the directory or
/// retrieving the URL to it. Client is responsible for removing
/// the directory even in case the temporary one was created.
@property (nonatomic, strong, nullable) NSURL *rootCaptureDirectory;
@property (nonatomic, assign) BOOL shouldCaptureInMemory;
@property (nonatomic, assign) BOOL isCountdownBeforeScanEnabled;
@property (nonatomic, assign) B3DHeadScannerSettingsScanMode scanMode;
/// Scan timings for currenntly set scan mode
@property (nonatomic, readonly, nullable) B3DScanTimings *scanTimings;

- (BOOL)loadDefaultSettingsWithError:(NSError ** _Nullable)outError;

/// Scan timings that will be used for a specified scan mode. The method returns copy of settings.
/// Changing properties of the returned object does not affect current scan settings object.
/// To update the scan settings itself use -setScanTimings:forScanMode:error: method.
- (nullable B3DScanTimings *)scanTimingsForScanMode:(B3DHeadScannerSettingsScanMode)scanMode;

/// Sets scan timings that will be used for a specified scan mode. When scan mode of current object is set
/// to the one that was specified to this method
- (BOOL)setScanTimings:(B3DScanTimings *)scanTimings
           forScanMode:(B3DHeadScannerSettingsScanMode)scanMode
                 error:(NSError ** _Nullable)error;

@end

NS_ASSUME_NONNULL_END
