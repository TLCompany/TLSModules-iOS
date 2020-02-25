//
//  AuthPolicyItemView.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
internal class AuthPolicyListItemCell: BaseTableViewCell {
    
    static let id = "AuthPolicyListItemCell"
    static let height: CGFloat = 32.0
    
    internal var row: Int = 0
    
    internal var checkedImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.agreeButton.setImage(self.checkedImage, for: .selected)
            }
        }
    }
    
    internal var uncheckedImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.agreeButton.setImage(self.uncheckedImage, for: .normal)
            }
        }
    }
    
    internal var policy: Policy? {
        didSet {
            guard let policy = self.policy else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "policy"))
                return
            }
            DispatchQueue.main.async {
                self.titleButton.setAttributedTitle(policy.title.underLined, for: .normal)
            }
        }
    }
    
    internal var isAgreed: Bool = false {
        didSet {
            guard let policy = self.policy, policy.isMandatory else {
                return
            }
            
            agreeButton.isSelected = self.isAgreed
        }
    }
    
    internal var agreeAction: ((Bool) -> Void)?
    internal var titleAction: ((Policy) -> Void)?
    
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchTitle(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func touchTitle(_ sender: UIButton) {
        guard let policy = self.policy else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "policy"))
            return
        }
        
        titleAction?(policy)
    }
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        let nImage = ResourcesProvider.image(by: "checkbox_unchecked")
        let sImage = ResourcesProvider.image(by: "checkbox_checked")
        button.setImage(nImage, for: .normal)
        button.setImage(sImage, for: .selected)
        button.setTitle(" 동의", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(touchAgree(_:)), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    private func touchAgree(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let policy = self.policy, policy.isMandatory else {
            return
        }
        agreeAction?(sender.isSelected)
    }
    
    override func setThingsUp() {
        
        contentView.isHidden = true
        selectionStyle = .none
        backgroundColor = .white
        addSubview(titleButton)
        addSubview(agreeButton)
        
        NSLayoutConstraint.activate([
            agreeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0),
            agreeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0),
            ])
    }
    
}
