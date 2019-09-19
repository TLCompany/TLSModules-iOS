//
//  AuthenticationViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import UIKit

/// 모든 Authentication 관련된 화면들의 조상 View Controller
open class AuthenticationViewController: UIViewController {
    
    public var hInset: CGFloat = 20.0
    public var vInset: CGFloat = 20.0
    public var completeButtonBackgroundColor = UIColor.init(hexString: "304786")
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        label.text = "title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hexString: "555555")
        label.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        label.text = "subtitle"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var leadingEdgeConstraint: NSLayoutConstraint!
    internal var trailingEdgeConstraint: NSLayoutConstraint!
    internal var topEdgeConstraint: NSLayoutConstraint!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpLayout()
        setUpInsets()
        setDescription(title: "Title", subtitle: "Subtitle")
    }
    
    private func setUpInsets() {
        guard hInset != 20.0, vInset != 20.0 else {
            return
        }
        
        leadingEdgeConstraint.constant = hInset
        trailingEdgeConstraint.constant = -hInset
        topEdgeConstraint.constant = vInset
        view.layoutIfNeeded()
    }
    
    public func setDescription(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    public func setUpLayout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        leadingEdgeConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0)
        trailingEdgeConstraint = titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0)
        topEdgeConstraint = titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0)
        
        leadingEdgeConstraint.isActive = true
        trailingEdgeConstraint.isActive = true
        topEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            ])
    }

}
