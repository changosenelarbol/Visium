//
//  LogInFormViewModel.swift
//  Visium
//
//  Created by developer on 27/06/21.
//

import UIKit

class LogInFormViewModel: NSObject {
    
    var didLogIn = { () -> ()  in }
    var didLogInFail =  { () -> ()  in }
    
    func logIn(userInfo: (email: String, password: String)) {

        ApiManager.logIn(user: userInfo.email, password: userInfo.password) { (token) in
           // print(token)
            SessionManager.shared.token = token
            self.didLogIn()
        } failure: {
          //  print("failure")
            self.didLogInFail()
        }
    }

}
