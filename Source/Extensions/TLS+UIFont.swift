//
//  TLS+UIFont.swift
//  Alamofire
//
//  Created by Justin Ji on 2019/12/18.
//

import UIKit

extension UIFont {
    
    public func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) 
    }

    public func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    public func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
