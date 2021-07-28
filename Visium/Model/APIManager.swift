//
//  APIManager.swift
//  Visium
//
//  Created by developer on 13/06/21.
//

import Foundation
import Alamofire
import UIKit

struct ApiManager {
    
    
    static func logIn(user: String, password: String, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        AF.request("https://zgnqyc3p4d.execute-api.us-west-2.amazonaws.com/api/login?content-type=application/json",
                   method: .post,
                   parameters: ["user_email": user, "password": password],
                   encoder: JSONParameterEncoder.default).response { response in
                    switch response.result {
                    case .success(let value):
                        if let json = try? JSONSerialization.jsonObject(with: value!, options: .allowFragments), let dic = json as? [String: Any], let token = dic["token"] as? String {
                            success(token)
                        } else {
                            failure()
                        }
                    case.failure(let error):
                        print(error.localizedDescription)
                        failure()
                        
                    }
                   }
    }
    
    static func register(email: String, password: String, firstName: String, lastName: String, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        AF.request("https://zgnqyc3p4d.execute-api.us-west-2.amazonaws.com/api/register?content-type=application/json",
                   method: .post,
                   parameters: ["user_email": email, "password": password, "first_name": firstName, "last_name": lastName],
                   encoder: JSONParameterEncoder.default).response { response in
                    debugPrint(response)
                    print(response)
                    switch response.result {
                    case .success(let value):
                        
                        if let stringFromData = String(data: value!, encoding: .utf8) {
                            print(stringFromData)
                            success(stringFromData)
                        } else {
                            failure()
                        }
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                        failure()
                        
                    }
                   }
    }
    
    static func forgotPasswordStepOne(email: String, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        AF.request("https://zgnqyc3p4d.execute-api.us-west-2.amazonaws.com/api/reset_password?content-type=application/json",
                   method: .post,
                   parameters: ["user_email": email],
                   encoder: JSONParameterEncoder.default).response { response in
                    debugPrint(response)
                    print(response)
                    switch response.result {
                    case .success(let value):
                        
                        if let stringFromData = String(data: value!, encoding: .utf8) {
                            print(stringFromData)
                            success(stringFromData)
                        } else {
                            failure()
                        }
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                        failure()
                        
                    }
                   }
    }
    
    static func forgotPasswordStepTwo(email: String, pin: String, newPassword: String, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        AF.request("https://zgnqyc3p4d.execute-api.us-west-2.amazonaws.com/api/reset_password?content-type=application/json",
                   method: .post,
                   parameters: ["user_email": email, "pin": pin, "password": newPassword],
                   encoder: JSONParameterEncoder.default).response { response in
                    debugPrint(response)
                    print(response)
                    switch response.result {
                    case .success(let value):
                        
                        if let stringFromData = String(data: value!, encoding: .utf8) {
                            print(stringFromData)
                            success(stringFromData)
                        } else {
                            failure()
                        }
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                        failure()
                        
                    }
                   }
    }
    
}
