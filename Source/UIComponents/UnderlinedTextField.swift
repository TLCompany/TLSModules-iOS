//
//  UnderlinedTextField.swift
//  Alamofire
//
//  Created by Justin Ji on 29/08/2019.
//

import UIKit

public class UnderlinedTextField: UITextField {

    private let underline = SeparatorView()
    
    override public var placeholder: String? {
        didSet {
            guard let placeholder = self.placeholder else {
                return
            }
            
            let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.init(hexString: "CECECE"), .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)]
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = .black
        borderStyle = .none
        let paddingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10.0, height: 10.0)))
        leftView = paddingView
        leftViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
        setUpLayout()
    }
    
    private func setUpLayout() {
        addSubview(underline)
        
        NSLayoutConstraint.activate([
            underline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1.5),
            underline.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
