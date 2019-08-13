//
//  UIStoryborad.swift
//  MansPouch_iOS
//
//  Created by Justin Ji on 10/01/2019.
//  Copyright © 2019 Justin Ji. All rights reserved.
//
import UIKit

extension UIStoryboard {

    static func viewController(_ storyBoardName : String, _ viewControllerID : String? = nil) -> UIViewController? {
        guard let viewControllerID = viewControllerID else {
            return UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()
        }
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
    }
}

