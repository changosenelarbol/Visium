//
//  LogInFormViewController.swift
//  Visium
//
//  Created by developer on 13/04/21.
//

import UIKit
import Alamofire

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
          
            
            
            ApiManager.getUrlToUploadFile(token: token, descriptin: "description") { (url) in
                print(url)
                SessionManager.shared.urlToUpload = url
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let scannViewController = storyboard.instantiateViewController(identifier: "ScanViewController")
                scannViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(scannViewController, animated: true)
                
               

//                if let zipFilePath = Bundle.main.path(forResource: "visiumscanAWS", ofType: "zip") {
//                    print(zipFilePath)
//                     let fileUrl = URL(fileURLWithPath: zipFilePath)
//                    guard let urlToUpload = SessionManager.shared.urlToUpload else { return }
//
//                    guard  let serverUrl: URL = URL(string: urlToUpload) else { return }
//
//
//
//
//                    ApiManager.uploadFile(fileUrl: fileUrl, serverUrl: serverUrl) { (message) in
//                        print(message)
//                    } failure: {
//                        print("error uploading zip")
//                    }
//
//
//
//                }
                
            } failure: {
                print("failure")
            }

            
            
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
