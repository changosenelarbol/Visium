//
//  TermsAndConditionsViewController.swift
//  Visium
//
//  Created by developer on 14/04/21.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Links To Docs"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EULAAction(_ sender: Any) {
        Alert.shared.showAlert(title: "Succes!!", alertType: .warning)
        Alert.shared.didPressOk = {
            print("xxx")
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
