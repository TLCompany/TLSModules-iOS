//
//  BaseTableViewCell.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
class BaseTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.listRowBackground
        setThingsUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setThingsUp() { }
    

}
