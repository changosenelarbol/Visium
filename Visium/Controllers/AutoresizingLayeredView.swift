//
//  AutoresizingLayeredView.swift
//  SampleApplication
//
//  Created by Bellus3D on 16/05/2019.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

import UIKit

class AutoresizingLayeredView: UIView {
  
  private lazy var layerID = "AutoresizingLayeredView.\(ObjectIdentifier(self))"
  
  var autoresizingLayer: CALayer? {
    didSet {
      layer.sublayers?.removeAll { $0.name == layerID }
      if let currentAutoresizingLayer = autoresizingLayer {
        currentAutoresizingLayer.name = layerID
        layer.insertSublayer(currentAutoresizingLayer, at: 0)
        adjustAutoresizingLayerSize()
      }
      
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    adjustAutoresizingLayerSize()
  }
  
  private func adjustAutoresizingLayerSize() {
    autoresizingLayer?.frame.size = bounds.size
    autoresizingLayer?.frame.origin = .zero
  }
  
}
