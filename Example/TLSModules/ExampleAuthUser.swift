//
//  ExampleAuthUser.swift
//  TLSModules_Example
//
//  Created by Justin Ji on 29/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import TLSModules

class ExampleAuthUser: AuthUser {
    
    var mobile: String?
    var email: String?
    var password: String
    
    init(email: String?, mobile: String?, password: String) {
        self.email = email
        self.mobile = mobile
        self.password = password
    }
    
}


