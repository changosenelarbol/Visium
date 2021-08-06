//
//  ViewController.swift
//  AlexTest
//
//  Created by Bellus3D.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//
//  Class to handle UI events for scanning/processing
//

import UIKit
import ARKit
import Bellus3D

class ScanViewController: UIViewController {

  @IBOutlet private var trackButton: UIButton?
  @IBOutlet private var scanButton: UIButton?
  @IBOutlet private var cancelButton: UIButton?
  @IBOutlet private var previewView: AutoresizingLayeredView?
  @IBOutlet private var instructionLabel: UILabel?
  @IBOutlet private var exportSwitch: UISwitch?

  private static let openViewerSegueID = "openViewer"
  private var currHint: Hint?
  private var headNode: SCNNode?
  private var texture: CGImage?
  private var cancelledByUser = false
  @available(iOS 11.1, *)
  private lazy var headScanner = HeadScanner(camera: B3DCamera(videoOrientation:  .portrait), delegate: self)
    private var urlOfFilesScanned: URL?
    
    
  @IBAction private func trackButtonPressed(_ sender: UIButton) {
    startTracking()
  }

  @IBAction private func scanButtonPressed(_ sender: UIButton) {
    startScanning()
  }
  
  @IBAction func cancelButtonPressed(_ sender: UIButton) {
    cancelScanning()
    instructionLabel?.text = "Scan cancelled"
  }

    @IBAction func showFilesAction(_ sender: Any) {
        
        if  let filesViewController = storyboard?.instantiateViewController(identifier: "FilesViewController") as? FilesViewController {
            
            self.navigationController?.pushViewController(filesViewController, animated: true)
           // self.present(filesViewController, animated: true, completion: nil)
            
        }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 11.1, *) {
     //   self.headScanner = HeadScanner(camera: B3DCamera(videoOrientation:  .portrait), delegate: self)
        self.scanButton?.layer.cornerRadius = (self.scanButton?.bounds.height)! / 2
      previewView?.autoresizingLayer = headScanner.previewLayer
    } else {
      instructionLabel?.text = "Scanning is available starting from iOS 11.1"
      trackButton?.isEnabled = false
      scanButton?.isEnabled = false
      cancelButton?.isEnabled = false
      exportSwitch?.isEnabled = false

    }
    instructionLabel?.textAlignment = .center
    exportSwitch?.isOn = false

  }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if #available(iOS 11.1, *) {
      if segue.identifier == Self.openViewerSegueID, let viewerViewController = segue.destination as? ViewerViewController {
        viewerViewController.headNode = headNode
        viewerViewController.texture = texture
        viewerViewController.urlOfFilesScanned = self.urlOfFilesScanned
      }
    }
  }

  private func startTracking() {
    if #available(iOS 11.1, *) {
      cancelledByUser = false
      headScanner.startTracking()
    } else {
      print("Scanning is available starting from iOS 11.1")
    }
  }
  
  private func startProcessing() {
    if #available(iOS 11.1, *) {
      headScanner.processModel(delegate: self)
    } else {
      print("Scanning is available starting from iOS 11.1")
    }
  }
  
  private func startScanning() {
    if #available(iOS 11.1, *) {
      cancelledByUser = false
      headScanner.startScanning()
      cancelButton?.isHidden = false
      trackButton?.isHidden = true
      scanButton?.isHidden = true
    } else {
      print("Scanning is available starting from iOS 11.1")
    }
  }
  
  @available(iOS 11.1, *)
  private func renderScannedHeadMesh(headScanner: HeadScanner) {
   
    if !(self.exportSwitch?.isOn ?? false) {
        self.showErrorAlert(message: "Export switch is off, you wont be able to see the render")
        return
    }
    
    guard let headMesh = headScanner.b3dHeadMesh else {
      print("Cannot get HeadMesh object from HeadScanner")
      return
    }
    
    // Activating Premium Features in order to retrieve Exporter object.
    // It's needed for exporting scanned mesh as file and to get SceneKit node to render it
		let modelInfo = B3DModelInfo(modelName: "VISIUM-BETA-TEST", userInfo: B3DUserInfo(email: "danderson@cloudmediaworks.com", fullName: "VISIUM-BETA-TEST", sex: B3DUserInfo.Sex.male, location: "Los Gatos CA", age: 64))
    print("Number of tokens currently stored on device: \(String(describing: B3DHeadMesh.numberOfCachedTokens))")
    
   
    headMesh.requestActivationOfPremiumFeatures(with: modelInfo, activationMethod: .byToken) { [weak self] exporter, error in
      guard let self = self else {
        print("\(Self.self) was deallocated before activating premium features")
        return
      }
      
      guard let exporter = exporter else {
        let errorMessage = "Cannot activate premium features. Error: \(String(describing: error))"
        print(errorMessage)
        self.showErrorAlert(message: errorMessage)
        return
      }
       
      
      guard let directoryURL = headScanner.getDirectory(named: "Output-files") else {
        let errorMessage = "Cannot get scanner directory"
        print(errorMessage)
        self.showErrorAlert(message: errorMessage)
        return
      }
        
        
      print("❤️directoryURL: \(directoryURL)")
     //  Exporting output 3D file and texture
        guard let urlOfFiles = HeadMeshDataExporter.exportFiles(exporter: exporter, toDirectoryAt: directoryURL) else {
            let errorMessage = "Cannot get files directory"
            print(errorMessage)
            self.showErrorAlert(message: errorMessage)
            return
        }
        
        print("❤️urlOfFiles: \(urlOfFiles)")

        self.urlOfFilesScanned = urlOfFiles
        
           
     //   if let urlOfFiles = URL(string: "file:///var/mobile/Containers/Data/Application/38E9D691-4638-4747-9E83-65D9226B7672/Documents/Output-files/1628139909.7949982/") {

        FilesManager.lastFileURL = urlOfFiles
        print("❤️ \(FilesManager.lastFileURL)")
        FilesManager.filesUrls.append(urlOfFiles)
        print("❤️ \(FilesManager.filesUrls)")
        
        
//        if (self.exportSwitch?.isOn ?? false) {
//
//    //     Make the activityViewContoller which shows the share-view
//        let activityViewController = UIActivityViewController(activityItems: [urlOfFiles], applicationActivities: nil)
//        activityViewController.completionWithItemsHandler = { (type,completed,items,error) in
//            self.performSegue(withIdentifier: Self.openViewerSegueID, sender: nil)
//
//        }
//        // Show the share-view
//        self.present(activityViewController, animated: true, completion: {
//        })
//
//        }
        
        // Createing objects from scanned HeadMesh to render them in Viewer
      let headMeshRenderingData = HeadMeshDataExporter.makeFaceNode(from: headMesh, exporter: exporter)
      // Storing objects to pass them to Viewer
      self.headNode = headMeshRenderingData?.node
      self.texture = headMeshRenderingData?.texture

      // Since we don't need HeadMesh object anymore we may clear memory it uses
      headMesh.clear()

      // Showing Viewer
        self.performSegue(withIdentifier: Self.openViewerSegueID, sender: nil)

    }
  }
  
  private func cancelScanning() {
    if #available(iOS 11.1, *) {
      headScanner.cancelScanning()
      scanButton?.isHidden = false
      cancelButton?.isHidden = true
      trackButton?.isHidden = false
      cancelledByUser = true
    } else {
      print("Scanning is available starting from iOS 11.1")
    }
  }
  
  @available(iOS 11.1, *)
  private func updateUI() {
    trackButton?.isEnabled = (headScanner.state != .tracking)
  }
  
  private func showErrorAlert(message: String) {
    let alert = UIAlertController(title: "Error",
                                  message: message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel))
    present(alert, animated: true)
  }
}

@available(iOS 11.1, *)
extension ScanViewController: HeadScannerProcessingDelegate {
  func headScanner(_ HeadScanner: HeadScanner, didReportProgress progress: Float) {
    instructionLabel?.text = String (progress * 100)
    print(progress * 100)
  }
  
  func headScanner(_ headScanner: HeadScanner, didCompleteRenderingSuccessfully completedSuccessfully: Bool) {
    cancelScanning()
    instructionLabel?.text = "Scan finished"
    if (completedSuccessfully) {
      renderScannedHeadMesh(headScanner: headScanner)
    }
  }
}

@available(iOS 11.1, *)
extension ScanViewController: HeadScannerDelegate {

  func headScannerIsReady(_ headScanner: HeadScanner) {
    print("Is ready to scan called.")
    updateUI()
  }

  func headScannerSessionInterrupted(_ headScanner: HeadScanner) {
    print("Session interupted.")
    updateUI()
  }

  func headScannerSessionResumed(_ headScanner: HeadScanner) {
    print("Session resumed.")
    updateUI()
  }

  func headScanner(_ headScanner: HeadScanner, cameraDidFailWithError error: Error) {
    print("Camera failed. Error: \(error.localizedDescription)")
    updateUI()
  }

  func headScanner(_ headScanner: HeadScanner, didProvideHint hint: Hint) {
    currHint = hint
    var text = currHint?.text ?? ""
    if headScanner.state == .tracking {
      text = "Tracking: \(text)"
    }
    
    instructionLabel?.text = text
    updateUI()
  }

  func headScanner(_ headScanner: HeadScanner, didCompleteScanningSuccessfully success: Bool) {
    if success {
      print("Scanning completed.")
      startProcessing()
    } else if cancelledByUser {
      print("Scanning cancelled.")
      cancelledByUser = false
      startTracking()
    }
    updateUI()
  }

  func headScanner(_ headScanner: HeadScanner, trackingDidFail error: Error?) {
    let trackingError = error as? B3DError
    // If we don't have access to camera tracking restart is useless until access is granted, so we're omitting it.
    // If tracking was cancelled we also should not restart it.
    if trackingError?.code != B3DError.accessToCameraNotGranted && trackingError?.code != B3DError.canceled {
      print("Tracking failed. Error: \(trackingError.debugDescription)")
    }
    updateUI()
  }

}
