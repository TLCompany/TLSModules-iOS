//
//  TLScrollView.swift
//  TLSModules
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

public class TLScrollView: UIScrollView {
    
    @discardableResult
    public func add(_ view: UIView,
                    topMargin: CGFloat = 0.0,
                    trailingMargin: CGFloat = 0.0,
                    leadingMargin: CGFloat = 0.0,
                    bottomMargin: CGFloat = 0.0) -> TLScrollView {
        
        containerView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let upperView = lastView != nil ? lastView! : containerView
        let yAnchor = upperView == lastView ? upperView.bottomAnchor : upperView.topAnchor
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: yAnchor, constant: topMargin),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingMargin),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingMargin),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomMargin)
            ])
        
        lastView = view
        return self
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var lastView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardDismissMode = .interactive
        setUpLayout()
    }
    
    private func setUpLayout() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
