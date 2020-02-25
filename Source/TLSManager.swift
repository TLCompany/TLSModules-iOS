//
//  DataManager.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

protocol TLSManager { }

@available(*, deprecated, message: "View-related classes are not supported.")
/// View-Related-Task Manager
open class VRTManager<T>: TLSManager {
    public var vc: UIViewController
    public func launch(with items: [T]) { }
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
}

/// Specific-Task-Oriented Manager
open class STOManager: TLSManager {
    
}

