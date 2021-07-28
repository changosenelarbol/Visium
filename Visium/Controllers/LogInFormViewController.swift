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
    @IBOutlet weak var emailTextField: RoundedUITextField!
    @IBOutlet weak var passwordTextField: RoundedUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log On"
        self.hideKeyboardWhenTappedAround()
        self.termsAndServiceButton.setTitle(title: "By logging in, you're accepting these \n Terms and Service")
        self.checkView.setTitle(title: "Remember user ID")
    }
    
    @IBAction func showPrivacyAndPolicyAction(_ sender: Any) {
        if  let termsAndConditionsViewController = storyboard?.instantiateViewController(identifier: "TermsAndConditionsViewController") as? TermsAndConditionsViewController {
            self.navigationController?.pushViewController(termsAndConditionsViewController, animated: true)
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        if  let resetPasswordViewController = storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as? ResetPasswordViewController {
            self.navigationController?.pushViewController(resetPasswordViewController, animated: true)
        }
    }
    
    @IBAction func logOnAction(_ sender: Any) {
        guard let userInfo = getUserAndPassword() else { return }
        ApiManager.logIn(user: userInfo.email, password: userInfo.password) { (token) in
            print(token)
            SessionManager.shared.token = token
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let scannViewController = storyboard.instantiateViewController(identifier: "ScanViewController")
            scannViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(scannViewController, animated: true)
        } failure: {
            print("failure")
        }
    }
    
    func getUserAndPassword() -> (email: String, password: String)? {
        guard let email = self.emailTextField.text else { return nil }
        guard let password = self.passwordTextField.text else { return nil }
        return (email, password)
    }
    
}
