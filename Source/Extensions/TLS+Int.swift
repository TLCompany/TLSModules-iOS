//
//  TLS+Int.swift
//  mibabeer
//
//  Created by Justin Ji on 31/05/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

extension Int {
    
    /// Integer로 되어 있는 돈의 금액(1000)을 단위가 찍힌 금액(1,000)으로 변경해주는 property
    public var formattedCurrency: String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))
    }
}
