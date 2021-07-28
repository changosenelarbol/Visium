//
//  HeadScanner.swift
//  SampleApplication
//
//  Created by Bellus3D
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//
//  Class handles all of scanning/processing functionality. 
//

//
//  Under License by
//  Cloud Media Works, LLC, dba Visium
//
//  Updated by Drew Anderson March 5, 2021
//  Portions Copyright ©2021 Cloud Media Works, LLC, All rights reserved.
//

import Foundation
import Bellus3D


enum FeatureActivationError: Error {
  case noExporterObject
}

@available(iOS 11.1, *)
protocol HeadScannerDelegate: AnyObject {
  func headScannerIsReady(_ headScanner: HeadScanner)
  func headScannerSessionInterrupted(_ headScanner: HeadScanner)
  func headScannerSessionResumed(_ headScanner: HeadScanner)
  func headScanner(_ headScanner: HeadScanner, cameraDidFailWithError error: Error)
  func headScanner(_ headScanner: HeadScanner, didProvideHint hint: Hint)
  func headScanner(_ headScanner: HeadScanner, didCompleteScanningSuccessfully completedSuccessfully: Bool)
  func headScanner(_ headScanner: HeadScanner, trackingDidFail error: Error?)
}

@available(iOS 11.1, *)
protocol HeadScannerProcessingDelegate: AnyObject {
  func headScanner(_ headScanner: HeadScanner, didReportProgress progress: Float)
  func headScanner(_ headScanner: HeadScanner, didCompleteRenderingSuccessfully completedSuccessfully: Bool)
}

@available(iOS 11.1, *)
class HeadScanner: NSObject {
  
  private weak var scannerDelegate: HeadScannerDelegate?
  private weak var processorDelegate: HeadScannerProcessingDelegate?
  
  private let headProcessor = B3DHeadProcessor()
  private let hintProvider = HintProvider()
  private let headScanner: B3DHeadScanner
  private(set) var b3dHeadMesh: B3DHeadMesh?
  private var sessionData: B3DHeadScanner.SessionData?
  private var currentSessionID = ""
  
  var state: B3DHeadScanner.State {
    headScanner.state
  }
  
  init(camera: B3DCamera, delegate: HeadScannerDelegate) {
    self.scannerDelegate = delegate
    self.headScanner = B3DHeadScanner(camera: camera)
    super.init()
    self.headScanner.addObserver(self)
    camera.addObserver(self)

    let credentials = B3DCredentials(clientID: "visiumwor35", clientSecret: "1bd5378b740d7531f91f13a3d772bc9f") // <--- Put your credentials here.
    // Authentication manager should be initialized with client credentials.
    // See the Bellus3D Partner Portal for your credentials: https://partner.bellus3d.com
    // This method should be called only once before using any other function from Bellus3D SDK.
    B3DAuthenticationManager.shared().initialize(with: credentials, callbackQueue: .main) { [weak self] error in
      if let error = error {
        print("Authentication manager initialization failed. Error: \(error.localizedDescription)")
      } else {
        self?.startTracking()
      }
    }
  }
  
  var previewLayer: CALayer? {
    return headScanner.previewLayer;
  }
  
  // Setting scanner settings, can use default or specify more specifics.
  // For more information see B3DHeadScannerSettings.h in Bellus3D.framework/Headers/
  private func headScannerSettings() -> B3DHeadScannerSettings {
    let headScannerSettings = B3DHeadScannerSettings()
    do {
      try headScannerSettings.loadDefaultSettings()
    } catch let error {
      print("Failed to load head scanner settings. Error: \(error.localizedDescription)")
    }
    
    // Different scan modes include 180(default), 270, and 270 long scan and 360 for full head.
		headScannerSettings.scanMode = B3DHeadScannerSettings.ScanMode.mode360Degrees
    headScannerSettings.rootCaptureDirectory = getDirectory(named: "Input-files")
    return headScannerSettings
  }
  
  func startTracking() {
    b3dHeadMesh?.clear()
    headScanner.startTracking()
  }
  
  func cancelScanning() {
    headScanner.cancel()
  }
  
  func startScanning() {
    currentSessionID = "\(Date().timeIntervalSince1970)"
    headScanner.settings = headScannerSettings()
    headScanner.startScanning()
  }
  
  // The following method shows you how to process a face model.
  // Specify different settings using the B3DHeadProcessorSettings.
  // For more information see B3DHeadProcessorSettings.h in Bellus3D.framework/Headers/
  func processModel(delegate: HeadScannerProcessingDelegate) {
    guard let data = sessionData else {
      print("No session data.")
      return
    }
    
    self.processorDelegate = delegate
    
    let headProcessorSettings = B3DHeadProcessorSettings()
    
    do {
      try headProcessorSettings.loadDefaultSettings() // Default settings is LD for resolution.
    } catch let error {
      print("Failed to load head processor settings. Error: \(error.localizedDescription)")
    }
    
    headProcessorSettings.rootOutputDirectory = getDirectory(named: "Output-files")
    headProcessorSettings.meshSmoothness = 5 // Specify a number from 0-10.
    headProcessorSettings.meshEnhancement = B3DHeadProcessorSettings.MeshEnhancement.byColor // Options for mesh enhancement are: none, byColor, byLandmarks, byColorAndLandmarks.
    headProcessor.settings = headProcessorSettings
    headProcessor.addObserver(self)
    self.headProcessor.startProcessing(with: data)
  }
  
  // Returns the URL for where files should be written.
  func getDirectory(named directoryName: String) -> URL? {
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      print("No 'Documents' directory found")
      return nil
    }
    let directoryURL = documentDirectory.appendingPathComponent(directoryName).appendingPathComponent(currentSessionID)
    do {
      try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
    } catch let error {
      print("Failed to create output directory. Error: \(error.localizedDescription)")
    }
    return directoryURL
  }
}

// Observer for Camera.
@available(iOS 11.1, *)
extension HeadScanner: B3DCameraObserver {
  
  func cameraDidStartStreaming(_ camera: B3DCamera) {
    scannerDelegate?.headScannerIsReady(self)
  }
  
  func cameraDidEndInterruption(_ camera: B3DCamera) {
    scannerDelegate?.headScannerSessionResumed(self)
  }
  
  func cameraDidStartInterruption(_ camera: B3DCamera) {
    scannerDelegate?.headScannerSessionInterrupted(self)
  }
  
  func camera(_ camera: B3DCamera, didFailWithError error: Error) {
    scannerDelegate?.headScanner(self, cameraDidFailWithError: error)
  }
}

// Observer for scanning.
@available(iOS 11.1, *)
extension HeadScanner: B3DHeadScannerObserver {

  func headScanner(_ headScanner: B3DHeadScanner, didProvide hint: B3DHeadScanner.ScanHint) {
    let aHint = hintProvider.handle(scanHint: hint)
    scannerDelegate?.headScanner(self, didProvideHint: aHint)
  }

  func headScanner(_ headScanner: B3DHeadScanner, didTrackFacePosition facePosition: B3DHeadScanner.FacePosition) {
    let aHint = hintProvider.hint(facePosition: facePosition)
    scannerDelegate?.headScanner(self, didProvideHint: aHint)
  }

  func headScanner(_ headScanner: B3DHeadScanner, didCompleteScanningSuccessfully completedSuccessfully: Bool, resultingSessionData: B3DHeadScanner.SessionData?) {
    if completedSuccessfully {
      sessionData = resultingSessionData
    }
    scannerDelegate?.headScanner(self, didCompleteScanningSuccessfully: completedSuccessfully)
  }

  func headScanner(_ headScanner: B3DHeadScanner, trackingDidFailWithError error: Error?) {
    scannerDelegate?.headScanner(self, trackingDidFail: error)
  }
  
}

// Observer for processing.
@available(iOS 11.1, *)
extension HeadScanner: B3DHeadProcessorObserver {
  
  func headProcessor(_ headProcessor: B3DHeadProcessor, didCompleteProcessingWith headMesh: B3DHeadMesh?) {
    let success = headMesh != nil
    if  headMesh != nil {
      b3dHeadMesh = headMesh
      sessionData?.clear()
    }
    processorDelegate?.headScanner(self, didCompleteRenderingSuccessfully: success)
  }
  
  func headProcessor(_ headProcessor: B3DHeadProcessor, didReportProgress progress: Float) {
    processorDelegate?.headScanner(self, didReportProgress: progress / 100)
  }
  
}
