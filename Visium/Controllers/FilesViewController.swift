//
//  FilesViewController.swift
//  Visium
//
//  Created by developer on 04/08/21.
//

import UIKit

class FilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilesManager.filesUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let urlOfFiles = FilesManager.filesUrls[indexPath.row]
        let splitArray = urlOfFiles.description.split(separator: "/")
        let splitedArrayLastElement = splitArray.last
        let folderNameArraySplit = splitedArrayLastElement?.split(separator: " ")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        
        if let folderName = folderNameArraySplit?.first {
            cell!.textLabel?.text = String(folderName)
        } else {
            cell!.textLabel?.text = "No File"

        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlOfFiles = FilesManager.filesUrls[indexPath.row]
        let splitArray = urlOfFiles.description.split(separator: "/")
        let splitedArrayLastElement = splitArray.last
        let folderNameArraySplit = splitedArrayLastElement?.split(separator: " ")
        guard let folderName = folderNameArraySplit?.first else { return }
        print(folderName)
        
        let urlOfFolder = self.getDirectory(named: "Output-files", folder: String(folderName))
        
        let activityViewController = UIActivityViewController(activityItems: [urlOfFolder!], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (type,completed,items,error) in

        }
        // Show the share-view
        self.present(activityViewController, animated: true, completion: {
        })
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Files"
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let zipFilePath = "file:///var/mobile/Containers/Data/Application/4CA14B91-DFA7-4444-8117-F1184300E254/Documents/Output-files/1628217357.661442/"
        let splitArray = zipFilePath.split(separator: "/")
        let folderName = splitArray.last
        print(folderName)
    }
    

    func getDirectory(named directoryName: String, folder: String) -> URL? {
        
        let     currentSessionID = "\(Date().timeIntervalSince1970)"
      guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("No 'Documents' directory found")
        return nil
      }
      let directoryURL = documentDirectory.appendingPathComponent(directoryName).appendingPathComponent(folder)
      do {
        try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("Failed to create output directory. Error: \(error.localizedDescription)")
      }
      return directoryURL
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
