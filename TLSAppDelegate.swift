//
//  TLSAppDelegate.swift
//  Alamofire
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

open class TLSAppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public var backButtonImage: UIImage? {
        didSet {
            guard let image = self.backButtonImage?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 10) else {
                return
            }
            UIBarButtonItem.appearance().title = ""
            
        }
    }
    
    public func setUpNavigationBar(tintColor: UIColor? = nil,
                                   backgroundColor: UIColor? = nil) {
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        
    }
    
    public func setUpRootViewController(_ rootViewController: UIViewController, isNavEmbedded: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootVC = isNavEmbedded ? UINavigationController(rootViewController: rootViewController) : rootViewController
        window?.rootViewController = rootVC
    }
    
}
