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
public enum NetworkResult {
    case success(message: String, data: Data?) // 200
    case sucfulyDataModified(message: String, data: Data?) // 201
    case invalidRequest(message: String) // 400
    case failure(message: String) //401
    case notAuthroised(message: String) // 403
    case noData(message: String) //404
    case cannotWrite(message: String) // 409
    case serverError(message: String) // 500
    case tokenExpired
    case tryAgain(with: String?) // 419
    case error(message: String)
    
    public var statusCode: Int {
        switch self {
        case .success: return 200
        case .sucfulyDataModified, .tryAgain: return 201
            case .invalidRequest: return 400
            case .failure: return 401
            case .notAuthroised: return 403
            case .noData: return 404
            case .cannotWrite: return 409
            case .serverError: return 500
            case .tokenExpired: return 419
            case .error: return 999
        }
    }
    
    public var errorMessage: String? {
        switch self {
        case .success(let message, _): return message
        case .sucfulyDataModified(let message, _): return message
        case .tryAgain, .tokenExpired: return nil
        case .invalidRequest(let message): return message
        case .failure(let message): return message
        case .notAuthroised(let message): return message
        case .noData(let message): return message
        case .cannotWrite(let message): return message
        case .serverError(let message): return message
        case .error(let message): return message
        }
    }
    public var json: [String: Any]? {
        switch self {
        case .success(_, let data), .sucfulyDataModified(_, let data):
            guard let data = data else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                return nil
            }
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        default: return nil
        }
    }
    
    public func model<T: Decodable>() -> T? {
        switch self {
        case .success(_, let data), .sucfulyDataModified(_, let data):
            guard let data = data else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                return nil
            }
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        default: return nil
        }
    }
}
