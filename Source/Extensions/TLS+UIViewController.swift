//
//  Extension+UIViewController.swift
//  BlueLink
//
//  Created by Justin Ji on 07/10/2018.
//  Copyright © 2018 Obigo. All rights reserved.
//
import UIKit

@available(iOS 10.0, *)
extension UIViewController {
    
    /// 시스템 경고 팝업 메세지를 보여줍니다.
    ///
    /// - Parameters:
    ///   - title: 제목
    ///   - message: 메세지
    ///   - buttonTitle: 버튼 제목
    func systemAlert(title: String? = nil,
                     message: String,
                     buttonTitle: String,
                     _ completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle , style: .default) { (action) in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// 시스템 경고 팝업 메세지를 보여줍니다.
    ///
    /// - Parameters:
    ///   - title: 제목
    ///   - pTitle: 긍정 버튼 제목
    ///   - nTitle: 부정 버튼 제목
    ///   - message: 메세지
    ///   - nActionCompletion: 부정 액션
    ///   - pActionCompletion: 긍정 액션
    func systemAlert(title: String? = nil,
                     pTitle : String,
                     nTitle : String,
                     message: String,
                     _ nActionCompletion: (() -> ())? = nil,
                     _ pActionCompletion: (() -> ())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let pAction = UIAlertAction(title: pTitle , style: .default) { (_) in
            pActionCompletion?()
        }
        let nAction = UIAlertAction(title: nTitle, style: .destructive) { _ in
            nActionCompletion?()
        }
        
        alert.addAction(nAction)
        alert.addAction(pAction)
        present(alert, animated: true, completion: nil)
    }
    
    func open(_ url: URL, completionHander completion: ((Bool) -> Void)? = nil) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: completion)
        } else {
            completion?(false)
        }
    }
}

