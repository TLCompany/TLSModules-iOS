//
//  DataManager.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

protocol TLSManager { }

/// View-Related-Task Manager
public class VRTManager<T>: TLSManager {
    public var vc: UIViewController
    public func go(with items: [T]) { }
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
}

/// Specific-Task-Oriented Manager
public class STOManager: TLSManager {
    
}
