//
//  B3DLogger.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 25/05/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, B3DLoggerLogLevel) {
  B3DLoggerLogLevelDebug = 0,
  B3DLoggerLogLevelError,
  B3DLoggerLogLevelWarning
};

typedef NS_CLOSED_ENUM(NSInteger, B3DLoggerFunctionType) {
  B3DLoggerFunctionTypeFreeFunction = 0,
  B3DLoggerFunctionTypeObjectMethod,
  B3DLoggerFunctionTypeClassMethod
};

@protocol B3DLogWriting;

OBJC_VISIBLE @interface B3DLogger : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, class, readonly) B3DLogger *sharedLogger;
@property (nonatomic, weak) id<B3DLogWriting> writer;

- (void)logMessage:(NSString *)message
             level:(B3DLoggerLogLevel)level
      functionName:(NSString *)functionName
      functionType:(B3DLoggerFunctionType)functionType
            object:(nullable id)object
          fileName:(NSString *)fileName
        lineNumber:(NSInteger)lineNumber;

- (void)setInternalLibraryLogFileURL:(NSURL *)logFileURL
                 shouldRemoveOldFile:(BOOL)shouldRemoveOldFile;

@end

OBJC_VISIBLE @protocol B3DLogWriting

- (void)writeLogWithLogger:(B3DLogger *)logger
                   message:(NSString *)message
                     level:(B3DLoggerLogLevel)level
              functionName:(NSString *)functionName
              functionType:(B3DLoggerFunctionType)functionType
         objectDescription:(nullable NSString *)objectDescription
                  fileName:(NSString *)fileName
                lineNumber:(NSInteger)lineNumber;

@end

NS_ASSUME_NONNULL_END
