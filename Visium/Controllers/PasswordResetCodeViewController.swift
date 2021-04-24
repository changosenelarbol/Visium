//
//  PasswordResetCodeViewController.swift
//  Visium
//
//  Created by developer on 23/04/21.
//

import UIKit

class PasswordResetCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        
        if  let passwordResetFormViewController = storyboard?.instantiateViewController(identifier: "PasswordResetFormViewController") as? PasswordResetFormViewController {
            self.navigationController?.pushViewController(passwordResetFormViewController, animated: true)
        }
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
