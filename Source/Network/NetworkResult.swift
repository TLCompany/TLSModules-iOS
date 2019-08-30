//
//  APIResult.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

//400 서버안에서 예외적 에러
//401 권한 없음
//404 요청한 정보가 없을 때
//200 요청한 데이터 불러오기 성공, 201 request에 보낸 데이터가 디비 저장성공
//202 보낸 요청에 대한 허용(저장X 불러오는 데이터X)
//500 서버오류

/// 통신결과의 타입을 알려주는 enumeration
///
/// - error: 예외적으로 일어나는 오류,
/// - unknown: StatusCode:400, 서버가 요청을 인식하지 못함.
/// - notAuthorised: StatusCode:401, 권한없음
/// - notFound: StatusCode:404, 서버가 요청한 페이지를 찾지 못함.
/// - sucfulyFetched: StatusCode:200, 요청한 데이터 불러오기 성공.
/// - sucfulySent: StatusCode:201, 보낸 데이터가 디비 저장성공.
/// - accepted: StatusCode:202, 보낸 요청에 대한 허용(저장X 불러오는 데이터X)
/// - serverError: StatusCode:500, 서버오류
/// - notPermitted: StatusCode:406, 요청한 페이지가 요청한 콘텐츠 특성으로 응답할 수 없다.
/// - tryAgain: 토큰만료, 다시 시도
public enum NetworkResult {
    case error(message: String)
    case unknown
    case notAuthorised
    case notFound
    case sucfulyFetched(data: Data?)
    case sucfulySent(data: Data?)
    case accepted
    case serverError
    case notPermitted
    case tryAgain(with: String?)
    
    var json: [String: Any]? {
        switch self {
        case .sucfulySent(let data), .sucfulyFetched(let data):
            guard let data = data else {
                NSLog("APIResult, data is nil")
                return nil
            }
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        default: return nil
        }
    }
    
    func model<T: Decodable>() -> T? {
        switch self {
        case .sucfulySent(let data), .sucfulyFetched(let data):
            guard let data = data else {
                NSLog("APIResult, data is nil")
                return nil
            }
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        default: return nil
        }
    }
}
