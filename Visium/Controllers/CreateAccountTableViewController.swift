//
//  CreateAccountTableViewController.swift
//  Visium
//
//  Created by developer on 23/04/21.
//

import UIKit

class CreateAccountTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: RoundedUITextField!
    @IBOutlet weak var lastNameTextField: RoundedUITextField!
    @IBOutlet weak var emailTextField: RoundedUITextField!
    @IBOutlet weak var passwordTextField: RoundedUITextField!
    @IBOutlet weak var confirmPasswordTextfield: RoundedUITextField!
    @IBOutlet weak var termsButton: RoundedUIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        self.title = "Create Account"
        let terms = NSAttributedString(string: "By creating an account you agree to our\nTerms of Service and Privacy Policy")
        self.termsButton.setAttributedTitle(terms, for: .normal)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getUserData() -> (firstName: String, lastName: String, email: String, password: String, confirmPassword: String) {
       
        var user: (firstName: String, lastName: String, email: String, password: String, confirmPassword: String) = ("","","","","")
        
        if let firstName = self.firstNameTextField.text {
            user.firstName = firstName
        }
        
        if let lastName = self.lastNameTextField.text {
            user.lastName = lastName
        }
        
        if let email = self.emailTextField.text {
            user.email = email
        }
        
        if let password = self.passwordTextField.text {
            user.password = password
        }
        
        if let confirmPassword = self.confirmPasswordTextfield.text {
            user.confirmPassword = confirmPassword
        }
        
        return user
    }

    @IBAction func continuedAction(_ sender: Any) {
        
        
        let userInfo = self.getUserData()
        print(userInfo)
        ApiManager.register(email: userInfo.email, password: userInfo.password, firstName: userInfo.firstName, lastName: userInfo.lastName) { (string) in
            print("succes registered")
        } failure: {
            
        }
        
//        ApiManager.register(email: "belen@gmail.com", password: "11111", firstName: "belen", lastName: "Quintero") { (string) in
//
//        } failure: {
//
//        }

        
    }
    // MARK: - Table view data source

   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
