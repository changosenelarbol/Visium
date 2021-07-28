//
//  SessionManager.swift
//  Visium
//
//  Created by developer on 27/06/21.
//

import UIKit

struct SessionManagerKeys {
    static let token = "token"
}

class SessionManager: NSObject {
    
    static let shared = SessionManager()
    private override init() {}

    var token : String? {
        get {
            return  UserDefaults.standard.string(forKey: SessionManagerKeys.token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: SessionManagerKeys.token)
        }
    }

}
