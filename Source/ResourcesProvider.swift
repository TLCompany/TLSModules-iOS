//
//  ResourcesProvider.swift
//  Alamofire
//
//  Created by Justin Ji on 29/08/2019.
//

import Foundation

class ResourcesProvider {
    
    internal static func image(by name: String) -> UIImage? {
        
        return UIImage(named: name, in: Bundle(for: ResourcesProvider.self), compatibleWith: nil)
    }
}
