//
//  AuthUser.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import Foundation

public protocol AuthUser {
    var email: String? { get set }
    var mobile: String? { get set }
    var password: String { get set }
}
