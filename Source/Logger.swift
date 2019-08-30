//
//  Logger.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import Foundation

public class Logger {
    public static func showError(at place: String = "", type: ErrorType) {
        NSLog(type.message + " 🌍 where: \(place)")
    }
    
    public static func showDebuggingMessage(at place: String = "", _ message: String) {
        NSLog(message + " 🌍 where: \(place)")
    }
}

public enum ErrorType {
    case unsafelyWrapped(taget: String)
    case network(errMsg: String)
    case error(errMsg: String)
    var message: String {
        switch self {
        case .unsafelyWrapped(let target): return "😱 Not safe to unwrap \(target)"
        case .network(let errMsg): return "🥶 Network failure: \(errMsg)"
        case .error(let msg): return "😡 Error: \(msg)"
        }
    }
}
