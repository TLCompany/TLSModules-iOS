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
    
    public func notificationConfiguration(application: UIApplication) {
        
        if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
    }
    
}


@available(iOS 10, *)
extension TLSAppDelegate : UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
//        let userInfo = notification.request.content.userInfo
        
        completionHandler([.alert])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
        
        completionHandler()
    }
}
