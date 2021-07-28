//
//  B3DHeadScannerSessionData.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 01/02/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Class represents data obtained after head scanning that should be used
/// for producing the head model
NS_SWIFT_NAME(B3DHeadScanner.SessionData)
OBJC_VISIBLE @interface B3DHeadScannerSessionData : NSObject

@property (nonatomic, readonly) BOOL empty;
@property (nonatomic, readonly, nullable) NSString *sessionID;
/// Root directory containing session working directories
@property (nonatomic, strong, nullable) NSURL *rootSessionDirectory;

/// Session working directory that is used by current session
@property (nonatomic, readonly, nullable) NSURL *currentSessionWorkingDirectory;

/// Loads session with the specified ID as a current one.
- (BOOL)loadSessionWithID:(NSString *)sessionID error:(NSError ** _Nullable)outError;

/// Removes internal data on disc or in memory (rgb files, depth files etc)
/// used by SessionData for further processing
- (void)clear;

@end

NS_ASSUME_NONNULL_END
