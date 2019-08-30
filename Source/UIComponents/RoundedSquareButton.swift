//
//  RoundedSquareButton.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import UIKit

public class RoundedSquareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5.0
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.init(hexString: "304786")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
