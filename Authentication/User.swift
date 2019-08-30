//
//  User.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

/// 앱 사용자의 데이터 모델의 protocol
public protocol User {
    var id: Int { get set }
    var clientSecret: String { get set }
    var token: String? { get set }
    var data: Data? { get }
}
