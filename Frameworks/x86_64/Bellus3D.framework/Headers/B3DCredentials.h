//
//  B3DAuthInfo.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 20/11/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE @interface B3DCredentials : NSObject

@property (nonatomic, readonly) NSString *clientID;
@property (nonatomic, readonly) NSString *clientSecret;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
