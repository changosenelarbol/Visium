//
//  APIManager.swift
//  Visium
//
//  Created by developer on 13/06/21.
//

import Foundation
import Alamofire
import UIKit

class UploadFileManager: NSObject, URLSessionTaskDelegate {
    
    
    lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
    var uploadingProgress: ((_ progress: Double) -> Void)?
    
    override init() {
        super.init()
    }
    
    func uploadFile(fileUrl: URL, serverUrl: URL, success: @escaping (String) -> (), failure: @escaping () -> (), progress: @escaping (_ progress: Double) -> Void) {
        
        self.uploadingProgress = progress
        guard let fileData = try? Data(contentsOf: fileUrl) else { return }
        var urlRequest = URLRequest.init(url: serverUrl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60);
        urlRequest.httpMethod = "PUT";
        urlRequest.setValue("", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("\(([UInt8](fileData)).count)", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("iPhone-OS", forHTTPHeaderField: "User-Agent")
        urlRequest.setValue("testImage", forHTTPHeaderField: "fileName")
        
        self.urlSession.uploadTask(with: urlRequest, from:fileData) { (data, response, error) in
            if error != nil {
                print(error!)
                failure()
            }else{
                
                print(response.debugDescription)
                if let httpResponse = response as? HTTPURLResponse {
                    // print("httpResponse.statusCode \(httpResponse.statusCode)")
                    httpResponse.statusCode == 200 ? success("File Uploaded") : failure()
                } else {
                    failure()
                }
                
            }
            
        }.resume()
        
    }
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        print("progress \(progress)")
        self.uploadingProgress?(progress)
        //  let handler = progressHandlersByTaskID[task.taskIdentifier]
        //   handler?(progress)
    }
}

class ApiManager: NSObject {
    
    struct HTTPBinResponse: Decodable { let url: String }
    static let shared = ApiManager()
    override init() {
        
    }
    lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
    
    
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
    
    
    static func getUrlToUploadFile(token: String, descriptin: String, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        AF.request("https://zgnqyc3p4d.execute-api.us-west-2.amazonaws.com/api/get_upload_url",
                   method: .post,
                   parameters: ["token": token, "desc": descriptin],
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
    
    
    
    static func uploadFile(fileUrl: URL, serverUrl: URL, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        //   guard let fileData = try? Data(contentsOf: fileUrl) else { return }
        
        
        let uploadFileManager = UploadFileManager()
        uploadFileManager.uploadFile(fileUrl: fileUrl, serverUrl: serverUrl) { (message) in
            print(message)
            success("File Uploaded")
        } failure: {
            failure()
            
        } progress: { (progress) in
            print(progress)
            
        }
        
    }
    
    
    func uploadtoSignedUrl(_ data: Data, _ url: URL, _ method: String) {
        var urlRequest = URLRequest.init(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60);
        urlRequest.httpMethod = method;
        urlRequest.setValue("", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("\(([UInt8](data)).count)", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("iPhone-OS", forHTTPHeaderField: "User-Agent")
        urlRequest.setValue("testImage", forHTTPHeaderField: "fileName")
        URLSession.shared.uploadTask(with: urlRequest, from:data) { (data, response, error) in
            if error != nil {
                print(error!)
                
            }else{
                print(String.init(data: data!, encoding: .utf8)!);
                
            }
            
        }.resume();
        
    }
    
    func requestSignedUrl(completion: @escaping ((_ url: URL, _ method: String) -> Void)) {
        var urlRequest = URLRequest.init(url: URL.init(string: "http://192.168.0.26:3000/users/testUser/objects")!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60);
        urlRequest.httpMethod = "POST";
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:                             JSONSerialization.ReadingOptions.mutableContainers)
                        if let jsonResult = jsonResult as? [String: Any] {
                            completion(URL.init(string: jsonResult["url"] as! String )!, jsonResult["method"] as! String)
                            
                        }
                        
                    } catch {
                        print("JSON parsing faild")
                        
                    }
                    
                }
                
            }
            
        }.resume()
        
    }
    
    
}

extension ApiManager: URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        print("progress \(progress)")
        //  let handler = progressHandlersByTaskID[task.taskIdentifier]
        //   handler?(progress)
    }
}
