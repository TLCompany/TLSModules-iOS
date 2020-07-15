//
//  DataAttachment.swift
//  TLSModules
//
//  Created by Justin Ji on 2020/02/26.
//

import Foundation

/**
 바이너리 데이터를 보내는 첨부 데이터 모델
*/
open class DataAttachment: MediumAttachment {
    public let data: Data
    public var name: String
    public var fileName: String
    public var type: MediumType
    
    public init(data: Data,
                name: String,
                fileName: String,
                type: MediumType) {
        
        self.data = data
        self.name = name
        self.fileName = fileName
        self.type = type
    }
}
