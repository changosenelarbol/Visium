//
//  Hint.swift
//  SampleApplication
//
//  Created by Bellus3D
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//
//  Object for Hint
//

import Foundation

struct Hint {

  enum HintType {
    case preScan
    case scan
    case isReadyToScan(Bool)
  }
  
  let type: HintType
  let text: String
}
