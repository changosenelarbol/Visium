//
//  ViewerViewController.swift
//  SampleApplication
//
//  Created by Bellus3D on 01/04/2019.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

import UIKit
import SceneKit.ModelIO

class ViewerViewController: UIViewController {
  
  var headNode: SCNNode?
  var texture: CGImage?
  var light: SCNLight?
  
  private var lightIntensity: CGFloat = 1500 {
    didSet {
      lightIntensityLabel?.text = "\(Int(lightIntensity))"
      if #available(iOS 10.0, *) {
        light?.intensity = lightIntensity
      }
    }
  }
  
  @IBOutlet private var sceneView: SCNView?
  @IBOutlet private var lightIntensityLabel: UILabel?
  @IBOutlet private var lightTypeLabel: UILabel?
  @IBOutlet var lightIntensitySlider: UISlider?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSceneView()
  }
  
  @IBAction func closeButtonTapped(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  @IBAction func textureSwitchAction(_ sender: UISwitch) {
    headNode?.geometry?.firstMaterial?.diffuse.contents = sender.isOn ? texture : UIColor.lightGray
  }
  
  @IBAction func lightIntensitySliderAction(_ sender: UISlider) {
    lightIntensity = CGFloat(sender.value)
  }
  @IBAction func lightButtonAction(_ sender: UIButton) {
    let sheet = UIAlertController(title: "Select light type", message: nil, preferredStyle: .actionSheet)
    sheet.popoverPresentationController?.sourceView = sender
    
    sheet.addAction(UIAlertAction(title: "Ambient", style: .default, handler: { [weak self] action in
      self?.lightTypeLabel?.text = "Light Type: Ambient"
      self?.light?.type = .ambient
      self?.update(lightIntensity: 200)
    }))
    
    sheet.addAction(UIAlertAction(title: "Directional", style: .default, handler: { [weak self] action in
      self?.lightTypeLabel?.text = "Light Type: Directional"
      self?.light?.type = .directional
      self?.update(lightIntensity: 1500)
    }))
    
    sheet.addAction(UIAlertAction(title: "Omni", style: .default, handler: { [weak self] action in
      self?.lightTypeLabel?.text = "Light Type: Omni"
      self?.light?.type = .omni
      self?.update(lightIntensity: 1500)
    }))
    
    sheet.addAction(UIAlertAction(title: "Spot", style: .default, handler: { [weak self] _ in
      self?.lightTypeLabel?.text = "Light Type: Spot"
      self?.light?.type = .spot
      self?.update(lightIntensity: 1200)
    }))
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    sheet.addAction(cancelAction)
    present(sheet, animated: true, completion: nil)
  }
  
  private func setupSceneView() {
    guard let node = headNode else {
      return
    }
    let scene = SCNScene()
    scene.rootNode.addChildNode(node)
    let lightingNode = lightNode()
    
    // This keeps the light center at the front of the screen.
    // Comment out to have light move with the face model.
    // It helps when viewing the mesh with a directional light.
    let lookAtConstraint = SCNBillboardConstraint()
    lightingNode.constraints = [lookAtConstraint]
    
    // This will make the model slightly shinny.
    // It helps when displaying the mesh.
    if let material = node.geometry?.firstMaterial {
          material.specular.contents = UIColor.init(white: 0.6, alpha: 1.0)
          material.specular.intensity = 0.2
    }
    
    scene.rootNode.addChildNode(lightingNode)
    lightingNode.position.z = node.boundingSphere.radius * 2
    sceneView?.scene = scene
    sceneView?.allowsCameraControl = true
  }
  
  
  func lightNode() -> SCNNode {
    let node = SCNNode()
    light = SCNLight()
    if #available(iOS 10.0, *) {
      light?.intensity = 200
    }
    
    lightTypeLabel?.text = "Light Type: Ambient"
    light?.type = .ambient

    node.light = light
    return node
  }
  
  private func update(lightIntensity: CGFloat) {
    self.lightIntensity = lightIntensity
    lightIntensitySlider?.value = Float(lightIntensity)
  }
}
