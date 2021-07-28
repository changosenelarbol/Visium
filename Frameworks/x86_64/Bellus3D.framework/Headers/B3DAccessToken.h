//
//  B3DAccessToken.h
//  Bellus3D-PublicDistribution
//
//  Created by Tomasz Walczyk on 13/03/2019.
//  Copyright © 2019 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_VISIBLE @interface B3DAccessToken : NSObject

@property (nonatomic, readonly) NSString *value;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSDate *expirationDate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithValue:(NSString *)value
                         type:(NSString *)type
               expirationDate:(NSDate *)expirationDate;

@end

NS_ASSUME_NONNULL_END
