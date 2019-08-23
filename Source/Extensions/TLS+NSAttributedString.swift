//
//  TLS+NSAttributedString.swift
//  Alamofire
//
//  Created by Justin Ji on 22/08/2019.
//

import Foundation

extension NSAttributedString {
    
    public static func placeholder(text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.placeholder, .font: UIFont.systemFont(ofSize: 13, weight: .regular)]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    public static func lineSpaced(by lineSpacing: CGFloat, text: String, textColor: UIColor = .black) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle, .foregroundColor: textColor], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
