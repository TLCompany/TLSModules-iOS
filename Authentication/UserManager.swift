//
//  UserManager.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

public class UserManager<T: Decodable>: NSObject {
    
    private let key = "tls_client"
    
    public var user: T? {
        get {
            guard let userData = UserDefaults.standard.object(forKey: key) as? Data else {
                showError(#function, type: .nil(taget: "userData"))
                return nil
            }
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: userData)
        }
        set {
            let newUser = newValue as? User
            UserDefaults.standard.set(newUser?.data, forKey: key)
            UserDefaults.standard.synchronize()
            NSLog("ClientManager", "😃 New user saved!")
        }
    }
    
    public var isSignedIn: Bool {
        return self.user == nil ? false : true
    }
}
