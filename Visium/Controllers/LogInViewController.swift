//
//  LogInViewController.swift
//  Visium
//
//  Created by developer on 12/04/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logOnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log On"
    }
    
    @IBAction func continueAsGuestAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scannViewController = storyboard.instantiateViewController(identifier: "ScanViewController")
        scannViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(scannViewController, animated: true)
    }
    
    @IBAction func logOnButtonAction(_ sender: Any) {
        if  let logInFormViewController = storyboard?.instantiateViewController(identifier: "LogInFormViewController") as? LogInFormViewController {
            
            self.navigationController?.pushViewController(logInFormViewController, animated: true)

         
           

        }
    }
    @IBAction func createAccountAction(_ sender: Any) {
        
        if  let createAccountTableViewController = storyboard?.instantiateViewController(identifier: "CreateAccountTableViewController") as? CreateAccountTableViewController {
            
            self.navigationController?.pushViewController(createAccountTableViewController, animated: true)
        }
    }
}
