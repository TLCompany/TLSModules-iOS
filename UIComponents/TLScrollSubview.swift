//
//  TLScrollSubview.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

open class TLScrollViewElement {

    public var margins: ScrollElementMargins
    public var subView: UIView
    
    init(subView: UIView,
         margins: ScrollElementMargins = ScrollElementMargins()) {
        
        self.subView = subView
        self.margins = margins
    }
}

public struct ScrollElementMargins {
    var top: CGFloat = 0.0
    var bottom: CGFloat = 0.0
    var leading: CGFloat = 0.0
    var trailing: CGFloat = 0.0
}
