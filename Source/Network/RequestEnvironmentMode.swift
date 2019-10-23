//
//  RequestEnvironmentMode.swift
//  Alamofire
//
//  Created by Justin Ji on 23/10/2019.
//

import Foundation

public enum RequestEnvironmentMode {
    case production
    case test
    case development
    
    public var identifier: String {
        switch self {
        case .development: return "tls_development"
        case .test: return "tls_test"
        case .production: return "tls_production"
        }
    }
    
    public static var currentMode: RequestEnvironmentMode {
        guard let identifier = UserDefaults.standard.object(forKey: .environmentMode) as? String else {
            return .development
        }
        switch identifier {
        case "tls_development": return .development
        case "tls_test": return .test
        case "tls_production": return .production
        default: fatalError("😱 System cannot find the application's environment mode")
        }
    }
}
