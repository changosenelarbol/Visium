//
//  HeadMesh.swift
//  SampleApplication
//
//  Created by Andrii Biehunov on 17/01/2020.
//  Copyright © 2021 Bellus3D, Inc. All rights reserved.
//

import Foundation
import SceneKit.ModelIO
import Bellus3D

enum HeadMeshDataExporter {
  
  // The following method shows you how to export model data.
  // For more information see B3DHeadMesh-Exporting.h and B3DHeadMeshExporter.h in Bellus3D.framework/Headers/
  // The file name passed will be NAME.ext, where ext is the file type you want to export.
  // Current file types supported are .obj, .stl, or .glb
  static func exportFiles(exporter: B3DHeadMeshExporter, toDirectoryAt directoryURL: URL) -> URL? {
    do {
      // Resolution of the exported model can be changed only using exporter object that is retrieved by activating Premium Features.
      exporter.meshResolution = .standard
    
      try exporter.exportMeshFilesToDirectory(at: directoryURL, filename: "test.obj.zip")
			try exporter.exportMeshFilesToDirectory(at: directoryURL, filename: "test.stl.zip")
      try exporter.exportPhotoViewsToFile(at: directoryURL.appendingPathComponent("photos.zip"), addViewer: true, captionText: "Photo")
        return directoryURL
    } catch let error {
      print("Failed to export model data. Error: \(error.localizedDescription)")
        return nil
    }
  }
  
  // The following method shows you how to create SceneKit SCNNode and texture that may be used to rendedr HeadMesh on screen.
  static func makeFaceNode(from mesh: B3DHeadMesh, exporter: B3DHeadMeshExporter) -> (node: SCNNode, texture: CGImage?)? {
    if (mesh.isEmpty) {
      print("Mesh is empty. Cannot create node or texture")
      return nil
    }

    let model: MDLMesh
    do {
      // Resolution of the resulting mesh data (retrieved from Head Mesh) can be changed only using an exporter object
      // that is retrieved by activating Premium Features.
      exporter.meshResolution = .high
      let polygonData = try mesh.polygonList()
      model = polygonData.modelMesh()
    } catch let error {
      print("Cannot create face mesh from \(mesh). Error: \(error)")
      return nil
    }
    
    let texture = mesh.texture()
    let node = SCNNode(mdlObject: model)
    if let material = node.geometry?.firstMaterial {
      let preferredMaterialSettings = B3DHeadMesh.preferredMaterialSettings()
      material.lightingModel = SCNMaterial.LightingModel(internalLightningModel: preferredMaterialSettings.lightningModel)
      material.ambient.contents = preferredMaterialSettings.ambientColor
      material.specular.contents = preferredMaterialSettings.specularColor
      material.transparency = CGFloat(preferredMaterialSettings.transparency)
      material.isDoubleSided = true
      material.diffuse.contentsTransform = SCNMatrix4Mult(material.diffuse.contentsTransform, preferredMaterialSettings.textureTransform)
      material.diffuse.contents = texture
      material.emission.contents = UIColor.black
    }
    return (node, texture)
  }
  
}

private extension SCNMaterial.LightingModel {
  
  init(internalLightningModel: B3DMaterialSettings.LightningModel) {
    switch internalLightningModel {
    case .phong:
      self = .phong
    default:
      self = .phong
    }
  }
  
}
