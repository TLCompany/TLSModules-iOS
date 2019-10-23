//
//  BasePopupViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 23/10/2019.
//

import UIKit

open class BasePopupViewController: UIViewController {
    
    public enum PopupType {
        case fadeIn, popup
    }
    
    public var type: PopupType = .popup
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false
        view.backgroundColor = .clear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.isOpaque = false
        view.backgroundColor = .clear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    var animator: CASpringAnimation?
    var basicAnimator: CABasicAnimation?
    
    public func show(popupView: UIView, completion: (() -> Void)? = nil) {
        switch type {
        case .fadeIn: animateFadeIn(popupView: popupView, completion: completion)
        case .popup: animatePopup(popupView: popupView, completion: completion)
        }
    }
    
    //TODO: add shadow to popupview
    private func addShadow(to popupView: UIView) {
        popupView.layer.shadowColor = UIColor.black.cgColor
        
    }
    
    private func animateFadeIn(popupView: UIView, completion: (() -> Void)? = nil) {
        
        let startVal = 0
        let endVal = 1
        let duration = 0.0
        
        basicAnimator = CABasicAnimation(keyPath: "opacity")
        basicAnimator?.fromValue = startVal
        basicAnimator?.toValue = endVal
        basicAnimator?.duration = duration
        
        popupView.layer.add(basicAnimator!, forKey: nil)
        completion?()
    }
    
    private func animatePopup(popupView: UIView, completion: (() -> Void)? = nil) {
        
        let middlePosition = CGPoint(x: popupView.frame.midX, y: popupView.frame.midY)
        let endPosition = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.height)
        let duration = 0.5
        
        animator = CASpringAnimation(keyPath: "position")
        animator?.mass = 0.4
        animator?.fromValue = endPosition
        animator?.toValue = middlePosition
        animator?.duration = duration
        
        popupView.layer.add(animator!, forKey: nil)
        completion?()
    }
    
    public func dismissPopupView(popupView: UIView) {
        switch type {
        case .fadeIn: fadeout(popupView: popupView)
        case .popup: dismiss(popupView: popupView)
        }
    }
    
    private func dismiss(popupView: UIView) {
        let middlePosition = CGPoint(x: popupView.frame.midX, y: popupView.frame.midY)
        let endPosition = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.height)
        let duration = 0.5
        
        animator = CASpringAnimation(keyPath: "position")
        animator?.mass = 0.4
        animator?.fromValue = middlePosition
        animator?.toValue = endPosition
        animator?.duration = duration
        
        popupView.layer.add(animator!, forKey: nil)
        popupView.isHidden = true
        view.backgroundColor = .clear
        dismiss(animated: true, completion: nil)
    }
    
    private func fadeout(popupView: UIView) {
        let startVal = 1
        let endVal = 0
        let duration = 0.5
        
        basicAnimator = CABasicAnimation(keyPath: "opacity")
        basicAnimator?.fromValue = startVal
        basicAnimator?.toValue = endVal
        basicAnimator?.duration = duration
        
        popupView.layer.add(basicAnimator!, forKey: nil)
        popupView.isHidden = true
        view.backgroundColor = .clear
        dismiss(animated: true, completion: nil)
    }
    
}
