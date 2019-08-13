//
//  User.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

public protocol User {
    var id: Int { get set }
    var clientSecret: String { get set }
    var token: String? { get set }
    var data: Data? { get }
}
