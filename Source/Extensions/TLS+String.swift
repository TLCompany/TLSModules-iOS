
//
//  String.swift
//  MansPouch_iOS
//
//  Created by Justin Ji on 10/01/2019.
//  Copyright © 2019 Justin Ji. All rights reserved.
//

import UIKit

extension String {
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    var underLined: NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: self, attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    var date: Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        dateformatter.locale = Locale(identifier: "ko_KR")
        return dateformatter.date(from: self)
    }
}
