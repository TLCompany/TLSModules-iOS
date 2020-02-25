//
//  RoundedSquareButton.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
@IBDesignable
class RoundedSquareButton: UIButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5.0
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
