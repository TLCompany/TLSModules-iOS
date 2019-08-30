//
//  AuthManager.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import Foundation

open class AuthManager<T>: VRTManager<AuthUser> {
    
    open func execute(completionHandler completion: ((T) -> Void)?) {
      
    }
    
    override public func launch(with items: [AuthUser]) {
        Logger.showError(at: #function, type: .error(errMsg: "This function cannot be used by this manager"))
    }
    
}
