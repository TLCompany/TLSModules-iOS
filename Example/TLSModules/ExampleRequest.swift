//
//  ExampleRequest.swift
//  TLSModules_Example
//
//  Created by Justin Ji on 30/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import TLSModules
import Alamofire

enum ExampleRequest: TLSRequest {
    case verification(body: [String: Any])
    
    var url: URL? {
        switch self {
        case .verification: return URL(string: baseURLStr + "/auth/sendEmail")
        }
    }
    
    
    var baseURLStr: String {
        return "http://192.160.0.67:8008"
    }
    
    var type: HTTPMethod {
        switch self {
        case .verification: return .post
        }
    }
    
    var body: [String : Any]? {
        get {
            switch self {
            case .verification(let body): return body
            }
        }
        set {
            
        }
    }
    
    var tokenRenewalURL: String {
        return ""
    }
    
    
}
