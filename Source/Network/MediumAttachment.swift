//
//  MediumAttachment.swift
//  Alamofire
//
//  Created by Justin Ji on 2020/02/26.
//

import Foundation

/**
 multipart form data를 첨부해서 요청할 때의 데이터 모델의 프로토콜
*/
internal protocol MediumAttachment {
    var name: String { get set }
    var fileName: String { get set }
    var type: MediumType { get set }
}

public enum MediumType {
    case image
    case video
    var text: String {
        switch self {
        case .image: return "image/jpeg"
        case .video: return "video/mp4"
        }
    }
}
