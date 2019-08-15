//
//  Announcement.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import Foundation

open class Announcement {
    
    public let id: Int
    public let title: String
    public let content: String
    public let date: Date
    
    public init(id: Int,
         title: String,
         content: String,
         date: Date) {
        
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
}
