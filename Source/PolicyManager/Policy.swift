//
//  Policy.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import Foundation

@available(*, deprecated, message: "View-related classes are not supported.")
class Policy {
    public let title: String
    public let content: String
    public var isMandatory: Bool = true
    
    public init(title: String, content: String, isMandatory: Bool = true) {
        self.title = title
        self.content = content
        self.isMandatory = isMandatory
        
    }
}
