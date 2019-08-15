//
//  TLS+Date.swift
//  mibabeer
//
//  Created by Justin Ji on 03/06/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

extension Date {
    
    /// TLS의 공식날짜 포맷의 텍스트
    public var formattedDateString: String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentDay = Calendar.current.component(.day, from: Date())
        let currnentSec = Calendar.current.component(.second, from: Date())
        let currnentHour = Calendar.current.component(.hour, from: Date())
        let currentMins = Calendar.current.component(.minute, from: Date())
        
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        let sec = Calendar.current.component(.second, from: self)
        let hour = Calendar.current.component(.hour, from: self)
        let mins = Calendar.current.component(.minute, from: self)
        
        if currentYear == year && currentMonth == month && currentDay == day {
            //해당당일일때
            if currnentSec == sec && currnentHour == hour && currentMins == mins {
                return "지금"
            } else if currentMins == mins && currnentSec > sec {
                return "\(currnentSec - sec)초 전"
            } else if currnentHour == hour && currentMins > mins {
                return "\(currentMins - mins)분 전"
            } else {
                let dateformatter = DateFormatter()
                dateformatter.amSymbol = "am"
                dateformatter.pmSymbol = "pm"
                dateformatter.dateFormat = "hh:mm a"
                return dateformatter.string(from: self)
            }
        } else if currentMonth == month && (currentDay - day) <= 3 {
            //3일 이내: 2019.01.22(2일전)
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyy.MM.dd"
            return "\(dateformatter.string(from: self)) (\(currentDay - day)일전)"
        } else {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyy.MM.dd"
            return "\(dateformatter.string(from: self))"
        }
    }
}
