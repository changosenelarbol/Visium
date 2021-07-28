//
//  B3DClient.h
//  Bellus3D-PublicDistribution
//
//  Created by Tomasz Walczyk on 25/04/2019.
//  Copyright © 2019 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B3DClientStatus) {
  B3DClientStatusTrial,
  B3DClientStatusDeployment,
  B3DClientStatusDevelopment
} NS_SWIFT_NAME(B3DClient.Status);

OBJC_VISIBLE @interface B3DClient : NSObject

@property (nonatomic, readonly) NSString *clientID;
@property (nonatomic, readonly) NSString *clientName;
@property (nonatomic, readonly) B3DClientStatus clientStatus;
@property (nonatomic, readonly) NSDate *sdkExpirationDate;
@property (nonatomic, readonly) NSUInteger modelTokensBatchSize;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithClientID:(NSString *)clientID
                      clientName:(NSString *)clientName
                    clientStatus:(B3DClientStatus)clientStatus
               sdkExpirationDate:(NSDate *)sdkExpirationDate
            modelTokensBatchSize:(NSUInteger)modelTokensBatchSize NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
