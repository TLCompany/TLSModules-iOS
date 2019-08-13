//
//  RequestResult.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

public enum RequestResult {
    case success(message: String?)
    case tryAgain
    case invalid(statusCode: Int?, message: String?)
    case error(statusCode: Int?, message: String?)
}


