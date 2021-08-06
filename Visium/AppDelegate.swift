//
//  AppDelegate.swift
//  Visium
//
//  Created by developer on 11/04/21.
//

import UIKit
import Bellus3D

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        B3DLogger.shared.writer = self
//        if let lastFiles = FilesManager.lastFileURL {
//        FilesManager.filesUrls.append(lastFiles)
//        print(FilesManager.filesUrls)
//        }
        
        
        
        
//        if let urlOfFiles = URL(string: "file:///var/mobile/Containers/Data/Application/38E9D691-4638-4747-9E83-65D9226B7672/Documents/Output-files/1628139909.7949982/") {
//
//        FilesManager.lastFileURL = urlOfFiles
//            print(FilesManager.lastFileURL)
//            FilesManager.filesUrls.append(urlOfFiles)
//            print(FilesManager.filesUrls)
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: B3DLogWriting {
  
  func writeLog(with logger: B3DLogger,
                message: String,
                level: B3DLoggerLogLevel,
                functionName: String,
                functionType: B3DLoggerFunctionType,
                objectDescription: String?,
                fileName: String,
                lineNumber: Int) {

    var calledName: String
    switch functionType {
    case .freeFunction:
      calledName = "'\(functionName)'"
    case .objectMethod:
      calledName = "'-\(functionName)'"
    case .classMethod:
      calledName = "'+\(functionName)'"
    default:
      calledName = "<unknown function>"
    }
    
    if let object = objectDescription {
      calledName = "\(object).\(calledName)"
    }
    let logLevel: String
    switch level {
    case .debug:
      logLevel = "[DEBUG]"
    case .error:
      logLevel = "[ERROR]"
    case .warning:
      logLevel = "[WARNING]"
    default:
      logLevel = "[UNKNOWN]"
    }
    
    print("[SDK] \(logLevel) \(calledName) \(fileName):\(lineNumber): \(message)")
    
  }
  
}
