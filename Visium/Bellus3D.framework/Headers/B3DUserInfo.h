//
//  B3DUserInfo.h
//  Bellus3D-PublicDistribution
//
//  Created by Andrii Biehunov on 03/12/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B3DUserInfoSex) {
  B3DUserInfoSexMale,
  B3DUserInfoSexFemale,
  B3DUserInfoSexUnspecified
} NS_SWIFT_NAME(B3DUserInfo.Sex);

OBJC_VISIBLE @interface B3DUserInfo : NSObject

@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) B3DUserInfoSex sex;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSInteger age;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithEmail:(NSString *)email
                     fullName:(NSString *)fullName
                          sex:(B3DUserInfoSex)sex
                     location:(NSString *)location
                          age:(NSInteger)age NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
