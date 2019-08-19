//
//  SeparatorView.swift
//  Alamofire
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

class SeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(hexString: "DEDEDE")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
