//
//  Request.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation
import Alamofire

public protocol Request {
    var url: URL? { get }
    var baseURLStr: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any]? { get }
    var tokenRenewalURL: String { get }
    var environmentMode: RequestEnvironmentMode { get }
}


