//
//  AlertMessage.swift
//  TLSModules
//
//  Created by Justin Ji on 16/09/2019.
//

import Foundation
import UIKit

/// 경고 메세지 또는 Action Sheet를 보여준다.
public class AlertMessage {
    
    private let alertController: UIAlertController?
    
    public init(title: String?, message: String, style: UIAlertController.Style) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    }
    
    @discardableResult
    /// 긍정 버튼을 추가한다.
    public func addPositiveButton(title: String, action: (() -> Void)? = nil) -> AlertMessage {
        let pAction = UIAlertAction(title: title, style: .default) { (_) in
            action?()
        }
        alertController?.addAction(pAction)
        return self
    }
    
    /// 부정 버튼을 추가한다.
    public func addNegativeButton(title: String, action: (() -> Void)? = nil) -> AlertMessage {
        let nAction = UIAlertAction(title: title, style: .destructive) { (_) in
            action?()
        }
        alertController?.addAction(nAction)
        return self
    }
    
    /// 취소 버튼을 추가한다.
    public func addCancelButton(title: String, action: (() -> Void)? = nil) -> AlertMessage {
        let cancel = UIAlertAction(title: title, style: .cancel) { (_) in
            action?()
        }
        alertController?.addAction(cancel)
        return self
    }
    
    /// 경고 메세지를 보여준다.
    public func show(by vc: UIViewController, completeAction: (() -> Void)? = nil) {
        guard let alertCtr = self.alertController else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "alertCtr"))
            return
        }
        vc.present(alertCtr, animated: true, completion: completeAction)
    }
}
