//
//  FilesManager.swift
//  Visium
//
//  Created by developer on 04/08/21.
//

import Foundation

class FilesManager {
    
    static var lastFileURL : URL? {
        get {
            let file =  UserDefaults.standard.url(forKey: "lastFileURL")
           // print(file)
            return file
        }
        set {
           // print(newValue)
            UserDefaults.standard.set(newValue, forKey: "lastFileURL")
        }
    }
    
    static var filesUrls : [URL] {
        get {
            let strings =  UserDefaults.standard.array(forKey: "filesArray") as? [String] ?? []
            let urls = strings.map { (url) -> URL in
                return URL(fileURLWithPath: url)
            }
            return urls
        }
        set {
            
            let arrayOfString: [String] = newValue.map { (url) -> String in
               return url.description
            }
            UserDefaults.standard.set(arrayOfString, forKey: "filesArray")
        }
    }
    
    static var zipFilesUrls : [URL] {
        get {
            let strings =  UserDefaults.standard.array(forKey: "zipFilesUrls") as? [String] ?? []
            let urls = strings.map { (url) -> URL in
                return URL(fileURLWithPath: url)
            }
            return urls
        }
        set {
            
            let arrayOfString: [String] = newValue.map { (url) -> String in
               return url.description
            }
            UserDefaults.standard.set(arrayOfString, forKey: "zipFilesUrls")
        }
    }
    
    static func zipFile(source: URL, name: String) -> URL? {
        
      
    let fm = FileManager.default
  //  let baseDirectoryUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
  
    let baseDirectoryUrl = source

        // populate the app's documents directory with some example files
    print(baseDirectoryUrl)
//    for i in 1...10 {
//        let fileUrl = baseDirectoryUrl.appendingPathComponent("\(i).txt")
//        let str = "\(i)"
//        try! str.write(to: fileUrl, atomically: true, encoding: .utf8)
//    }

    // this will hold the URL of the zip file
    var archiveUrl: URL?
    // if we encounter an error, store it here
    var error: NSError?

    let coordinator = NSFileCoordinator()
    // zip up the documents directory
    // this method is synchronous and the block will be executed before it returns
    // if the method fails, the block will not be executed though
    // if you expect the archiving process to take long, execute it on another queue
    coordinator.coordinate(readingItemAt: baseDirectoryUrl, options: [.forUploading], error: &error) { (zipUrl) in
        // zipUrl points to the zip file created by the coordinator
        // zipUrl is valid only until the end of this block, so we move the file to a temporary folder
        let tmpUrl = try! fm.url(
            for: .itemReplacementDirectory,
            in: .userDomainMask,
            appropriateFor: zipUrl,
            create: true
        ).appendingPathComponent("archive.zip")
        try! fm.moveItem(at: zipUrl, to: tmpUrl)

        // store the URL so we can use it outside the block
        archiveUrl = tmpUrl
       
    }

    
       return archiveUrl
   
   }
}
