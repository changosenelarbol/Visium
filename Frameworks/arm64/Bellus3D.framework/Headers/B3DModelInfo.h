//
//  B3DModelInfo.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 20/11/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class B3DUserInfo;

OBJC_VISIBLE @interface B3DModelInfo : NSObject

@property (nonatomic, readonly) NSString *modelName;
@property (nullable, nonatomic, readonly) B3DUserInfo *userInfo;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithModelName:(NSString *)modelName;
- (instancetype)initWithModelName:(NSString *)modelName
                         userInfo:(nullable B3DUserInfo *)userInfo NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
