//
//  ResetPasswordViewController.swift
//  Visium
//
//  Created by developer on 16/04/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        
        if  let passwordResetCodeViewController = storyboard?.instantiateViewController(identifier: "PasswordResetCodeViewController") as? PasswordResetCodeViewController {
            self.navigationController?.pushViewController(passwordResetCodeViewController, animated: true)
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