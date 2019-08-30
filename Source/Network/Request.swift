//
//  Request.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation
import Alamofire

public protocol TLSRequest {
    var url: URL? { get }
    var baseURLStr: String { get }
    var type: HTTPMethod { get }
    var body: [String: Any]? { get set }
    var tokenRenewalURL: String { get }
}


