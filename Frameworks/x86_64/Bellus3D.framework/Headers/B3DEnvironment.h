//
//  B3DEnvironment.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 07/02/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Sets URL to directory that contains setting files needed for correct functioning of framework.
/// URL should point to directory that contains a single directory named SDK. This SDK directory itself
/// should have the following structure:
///
/// @code
/// > Configuration/
///   > B3DCamera/
///   > DeviceCamera/
///     > CalibrationData/
/// > Thirdparty/
///   > stasm4.1.0/
///     > data/
/// @endcode
/// Configuration directory and its subdirectories contain .yml setting files
/// Thirdparty/stasm4.1.0/data directory is REQUIRED and contains .xml setting files for stasm library.
/// @param settingsDirectoryURL URL to directory that contains setting files. Passing nil will reset environment settings to default value.
/// @return Returns YES is operation succeeded, NO otherwise.
OBJC_EXPORT BOOL B3DSetEnvironmentSettingsDirectoryURL(NSURL * _Nullable settingsDirectoryURL);

/// Returns current URL to directory that contains setting files needed for correct functioning of framework.
/// This method may return nil if default settings from framework's bundle could not be unzipped.
OBJC_EXPORT NSURL * _Nullable B3DGetEnvironmentSettingsDirectoryURL();

NS_ASSUME_NONNULL_END
