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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logOnButtonAction(_ sender: Any) {
        if  let logInFormViewController = storyboard?.instantiateViewController(identifier: "LogInFormViewController") as? LogInFormViewController {
            
            self.navigationController?.pushViewController(logInFormViewController, animated: true)
            
    
      
    }
    }
}
