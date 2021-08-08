//
//  FilesViewController.swift
//  Visium
//
//  Created by developer on 04/08/21.
//

import UIKit

class FilesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        
        cell?.backgroundColor = .black
        cell?.textLabel?.textColor = .white
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let urlOfFiles = FilesManager.filesUrls[indexPath.row]
        let splitArray = urlOfFiles.description.split(separator: "/")
        let splitedArrayLastElement = splitArray.last
        let folderNameArraySplit = splitedArrayLastElement?.split(separator: " ")
        guard let folderName = folderNameArraySplit?.first else { return }
        self.folderName = String(folderName)
     //   print(folderName)
        
     /*   let urlOfFolder = self.getDirectory(named: "Output-files", folder: String(folderName))
        
        if let zipFile = FilesManager.zipFile(source: urlOfFolder!, name: String(folderName)) {
            
            guard let urlToUpload = SessionManager.shared.urlToUpload else { return }
            
            guard  let serverUrl: URL = URL(string: urlToUpload) else { return }
            ApiManager.uploadFile(fileUrl: zipFile, serverUrl: serverUrl) { (message) in
                print(message)
            } failure: {
                print("error uploading zip")
            }
            

        }*/
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.folderName = nil
    }
    

    @IBOutlet weak var tableView: UITableView!
    var share: UIBarButtonItem!
    var upload: UIBarButtonItem!
    
    var folderName: String? {
        didSet {
            navigationItem.rightBarButtonItems =  folderName == nil ? [] : [share, upload]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Files"
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
         share = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareFile))
        share.tintColor = .yellow
         upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(uploadFile))
        upload.tintColor = .orange


      
        
    }
    
    @objc func shareFile() {
        
        guard let folderName = self.folderName else { return }
        let urlOfFolder = self.getDirectory(named: "Output-files", folder: String(folderName))
        if let zipFile = FilesManager.zipFile(source: urlOfFolder!, name: String(folderName)) {

        let activityViewController = UIActivityViewController(activityItems: [zipFile], applicationActivities: nil)
               activityViewController.completionWithItemsHandler = { (type,completed,items,error) in
   
               }
               // Show the share-view
               self.present(activityViewController, animated: true, completion: {
               })
    }
    }
    
    @objc func uploadFile() {
        
        self.activityIndicatorBegin()
        guard let folderName = self.folderName else { return }

           let urlOfFolder = self.getDirectory(named: "Output-files", folder: String(folderName))
           
           if let zipFile = FilesManager.zipFile(source: urlOfFolder!, name: String(folderName)) {
               
               guard let urlToUpload = SessionManager.shared.urlToUpload else { return }
               
               guard  let serverUrl: URL = URL(string: urlToUpload) else { return }
               ApiManager.uploadFile(fileUrl: zipFile, serverUrl: serverUrl) { (message) in
                   print(message)
                self.activityIndicatorEnd()

                Alert.shared.showAlert(title: message, alertType: .succes)
                
               } failure: {
                   print("error uploading zip")
                self.activityIndicatorEnd()
                Alert.shared.showAlert(title: "Error uploading zip", alertType: .failure)

               }
               

           }
    }
    

    func getDirectory(named directoryName: String, folder: String) -> URL? {
        
     //   let     currentSessionID = "\(Date().timeIntervalSince1970)"
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
