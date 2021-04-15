//
//  LogInFormViewController.swift
//  Visium
//
//  Created by developer on 13/04/21.
//

import UIKit

class LogInFormViewController: UIViewController {

    @IBOutlet weak var termsAndServiceButton: RoundedUIButton!
    @IBOutlet weak var checkView: CheckBoxWithTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.termsAndServiceButton.setTitle(title: "By logging in, you're accepting these \n Terms and Service")
        self.checkView.setTitle(title: "Remember user ID")
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

}
