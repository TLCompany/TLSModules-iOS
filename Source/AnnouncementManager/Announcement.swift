//
//  Announcement.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import Foundation

public typealias JSON = [String: Any]

/// 공지사항의 데이터 모델
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
    
    public init?(json: JSON) {
        guard let id = json["id"] as? Int else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "id"))
            return nil
        }
        self.id = id
        
        guard let title = json["title"] as? String else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "title"))
            return nil
        }
        self.title = title
        
        guard let content = json["content"] as? String else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "content"))
            return nil
        }
        self.content = content
        
        guard let dateString = json["createdAt"] as? String else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "dateString"))
            return nil
        }
        
        guard let date = String(dateString.split(separator: ".").first!).date else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "date"))
            return nil
        }
        self.date = date
    }
}
