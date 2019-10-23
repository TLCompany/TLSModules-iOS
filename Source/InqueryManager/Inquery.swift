//
//  Inquery.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import Foundation

/// 문의사항의 데이터 모델
open class Inquery: Decodable {
    public let id: Int
    public let content: String
    public let answer: String?
    public let date: Date
    public let isAnswered: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "content"
        case answer = "answer"
        case date = "date"
        case isAnswered = "isAnswered"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.content = try values.decode(String.self, forKey: .content)
        self.answer = try values.decode(String.self, forKey: .answer)
        self.date = try values.decode(Date.self, forKey: .date)
        self.isAnswered = try values.decode(Bool.self, forKey: .isAnswered)
    }
    
    public init(id: Int,
         content: String,
         answer: String?,
         date: Date,
         isAnswered: Bool) {
        
        self.id = id
        self.content = content
        self.answer = answer
        self.date = date
        self.isAnswered = isAnswered
    }
    
    public init?(json: JSON) {
        guard let id = json["id"] as? Int else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "id"))
            return nil
        }
        self.id = id
        
        guard let content = json["content"] as? String else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "content"))
            return nil
        }
        self.content = content
        
        self.answer = json["answer"] as? String
        self.isAnswered = self.answer == nil ? false : true
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
