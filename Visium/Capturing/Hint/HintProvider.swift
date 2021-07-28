//
//  HintProvider.swift
//  SampleApplication
//
//  Created by Bellus3D
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//
//  Class handles text updates to provide feedback for tracking/scanning
//

import Foundation
import AVFoundation
import AudioToolbox
import Bellus3D

class HintProvider {

  // Handles text updates from headscanner scanHint.
  @available(iOS 11.1, *)
  func handle(scanHint: B3DHeadScanner.ScanHint) -> Hint {
    let text: String
    var hintType = Hint.HintType.scan
    switch scanHint {
    case .captureCompleted:
      text = "Capture Complete"
			AudioServicesPlaySystemSound(SystemSoundID(1118))
    case .turnHeadLeft:
      text = "Turn Left"
			AudioServicesPlaySystemSound(SystemSoundID(1105))
    case .turnHeadRight:
      text = "Turn Right"
			AudioServicesPlaySystemSound(SystemSoundID(1105))
    case .turnHeadToTheMiddle:
      text = "Turn to Middle"
			AudioServicesPlaySystemSound(SystemSoundID(1104))
    case .turnHeadUp:
      text = "Tilt your head up"
			AudioServicesPlaySystemSound(SystemSoundID(1109))
    case .turnHeadDown:
      text = "Tilt your head down"
			AudioServicesPlaySystemSound(SystemSoundID(1109))
    case .countdownOne:
      text = "1"
    case .countdownTwo:
      text = "2"
    case .countdownThree:
      text = "3"
    case .holdStill:
      text = "Hold Still"
      hintType = .preScan
    default:
      text = "Hint #\(scanHint.rawValue)"
      print(text)
			
    }
    return Hint(type: hintType, text: text)
  }

  // Handles text updates for tracking.
  @available(iOS 11.1, *)
  func hint(facePosition facePos: B3DHeadScanner.FacePosition) -> Hint {
    let text: String
    var isReadyToScan = false
    switch facePos {
    case .faceNotCentered:
      text = "Face Not Centered"
			AudioServicesPlaySystemSound(SystemSoundID(4095))
    case .faceNotFound:
      text = "No Face found!"
    case .faceTooFar:
      text = "Face Too Far"
			//AudioServicesPlaySystemSound(SystemSoundID(4095))
    case .notAvailable:
      text = "Preparing New Scan"
			AudioServicesPlaySystemSound(SystemSoundID(1109))
    case .faceTooClose:
      text = "Face Too Close!"
			//AudioServicesPlaySystemSound(SystemSoundID(4095))
    case .readyToScan:
      text = "Press Scan to Save!"
      isReadyToScan = true
    case .faceNotFrontal:
      text = "Face Not Frontal"
			AudioServicesPlaySystemSound(SystemSoundID(4095))
    default:
      text = "Face position #\(facePos.rawValue)"
    }
		
    return Hint(type: .isReadyToScan(isReadyToScan), text: text)
  }

}
