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
public class DataAttachment: MediumAttachment {
    let data: Data
    var name: String
    var fileName: String
    var type: MediumType
    
    init(data: Data,
         name: String,
         fileName: String,
         type: MediumType) {
        
        self.data = data
        self.name = name
        self.fileName = fileName
        self.type = type
    }
}