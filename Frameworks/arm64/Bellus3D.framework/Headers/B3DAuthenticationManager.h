//
//  B3DAuthenticationManager.h
//  Bellus3D-PublicDistribution
//
//  Created by Tomasz Walczyk on 11/03/2019.
//  Copyright © 2019 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class B3DCredentials;

NS_ASSUME_NONNULL_BEGIN

/// Class handles client authentication with Bellus3D Face Cloud API.
OBJC_VISIBLE @interface B3DAuthenticationManager : NSObject

/// Returns whether authentication manager has been initialized.
@property (readonly) BOOL isInitialized;

/// Deprecated. returns result of isValidatedByServer property.
@property (readonly) BOOL isAuthorised __attribute((deprecated("Use isValidatedByServer instead.", "isValidatedByServer")));

/// Returns whether the Bellus3D SDK client is validated by Bellus3D server.
@property (readonly) BOOL isValidatedByServer;

/// Returns authentication manager used by Bellus3D SDK to unlock premium features.
+ (B3DAuthenticationManager *)shared;

/// Initializes object with client credentials and callback queue.
/// This method should be called only once before using any other function from Bellus3D SDK.
- (void)initializeWithCredentials:(B3DCredentials *)credentials
                    callbackQueue:(dispatch_queue_t)callbackQueue
                completionHandler:(void(^)(NSError * _Nullable))completionHandler;

/// This method was used to activate SDK. Activation is no longer required. Now the method does not do anything and
/// is left in interface only for backward compatibility. It just calls its completion handler.
/// For more info check -requestServerValidationWithCompletionHandler method.
- (void)activateSDKWithCompletionHandler:(void(^)(NSError * _Nullable))completionHandler
    __attribute((deprecated("Method is no longer required to be called. "
                            "Currently it just calls its completion handler.")));

/// Validates Bellus3D SDK by Bellus3D server. It's not required to call this method directly.
/// When other methods that require server validation (e.g., activating premium features) are called and SDK is not validated by server
/// the methods will call this method automatically. However you may call this method manually if needed. E.g., it may be called to
/// perform server validation before showing some UI requiring premium features.
/// This method an be called multiple times to refresh status of client developer account or to deal with network connectivity errors.
/// The method should be called only after initialization of authentication manager is completed.
- (void)requestServerValidationWithCompletionHandler:(void(^)(NSError * _Nullable))completionHandler;

@end

NS_ASSUME_NONNULL_END
