//
//  B3DMaterialSettings.h
//  Bellus3D
//
//  Created by Andrii Biehunov on 03/07/2018.
//  Copyright © 2018 Bellus3D, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, B3DMaterialSettingsLightningModel) {
  B3DMaterialSettingsLightningModelPhong
} NS_SWIFT_NAME(B3DMaterialSettings.LightningModel);

@class UIColor;

/// Represents a set of settings that may be applied by the client for rendering the model
@interface B3DMaterialSettings : NSObject

@property (nonatomic, assign) B3DMaterialSettingsLightningModel lightningModel;
@property (nonatomic, strong) UIColor *diffuseColor;
@property (nonatomic, strong) UIColor *ambientColor;
@property (nonatomic, strong) UIColor *specularColor;
@property (nonatomic, assign) double transparency;

@end

NS_ASSUME_NONNULL_END
