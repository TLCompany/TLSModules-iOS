//
//  TLS+Dictionary.swift
//  TLSModules
//
//  Created by Justin Ji on 29/08/2019.
//

import Foundation

extension Dictionary {
    
    /// 서버와 통신할때 Data 안에 넣어서 보내준다.
    public var data: [String: Any] {
        return ["Data": self]
    }
}
