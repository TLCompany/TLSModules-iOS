//
//  TLS+Object.swift
//  mibabeer
//
//  Created by Justin Ji on 31/05/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation

extension NSObject {
    
    public func showError(_ place: String, type: ErrorType) {
        NSLog(place + type.message)
    }
    
    /// HTTP 서버통신 결과를 완료해주는 함수 - Generic 데이터 모델 리턴
    ///
    /// - Parameters:
    ///   - apiResult: 통신 결과
    ///   - successAction: 성공했을 때
    ///   - tryAgainAction: 토큰 갱신 후 리턴
    public func evaluate<T: Decodable>(apiResult: APIResult,
                                successAction: ((T?) -> Void)? = nil,
                                tryAgainAction: (() -> Void)? = nil) {

        switch apiResult {
        case .error(let message):
            showError(#function, type: .error(errMsg: message))
        case .unknown:
            showError(#function, type: .error(errMsg: "😱 unknown error"))
        case .notAuthorised:
            showError(#function, type: .error(errMsg: "😱 not authorised"))
        case .notFound:
            showError(#function, type: .error(errMsg: "😱 no params sent with"))
        case .sucfulyFetched(_):
            successAction?(apiResult.model())
        case .sucfulySent(_):
            successAction?(apiResult.model())
        case .accepted:
            successAction?(nil)
        case .serverError:
            showError(#function, type: .error(errMsg: "😱 server error"))
        case .tryAgain:
            tryAgainAction?()
        case .notPermitted:
            showError(#function, type: .error(errMsg: "😱 not permitted"))
        }
    }
    
    /// HTTP 서버통신 결과를 완료해주는 함수 - JSON 리턴
    ///
    /// - Parameters:
    ///   - apiResult: 통신 결과
    ///   - successAction: 성공했을 때
    ///   - tryAgainAction: 토큰 갱신 후 리턴
    public func evaluate(apiResult: APIResult,
                  successAction: (([String: Any]?) -> Void)? = nil,
                  failureAction: ((String) -> Void)? = nil,
                  tryAgainAction: (() -> Void)? = nil) {
        
        switch apiResult {
        case .error(let message):
            showError(#function, type: .error(errMsg: message))
            failureAction?("😱 \(message)")
        case .unknown:
            showError(#function, type: .error(errMsg: "😱 unknown error"))
            failureAction?("😱 unknown error")
        case .notAuthorised:
            showError(#function, type: .error(errMsg: "😱 not authorised"))
            failureAction?("😱 not authorised")
        case .notFound:
            showError(#function, type: .error(errMsg: "😱 no params sent with"))
            failureAction?("😱 no data to return")
        case .sucfulyFetched:
            successAction?(apiResult.json)
        case .sucfulySent:
            successAction?(apiResult.json)
        case .accepted:
            successAction?(nil)
        case .serverError:
            showError(#function, type: .error(errMsg: "😱 server error"))
        case .tryAgain:
            tryAgainAction?()
        case .notPermitted:
            failureAction?("😱 not permitted")
        }
    }
    
}

public enum ErrorType {
    case unsafelyWrapped(taget: String)
    case `nil`(taget: String)
    case network(errMsg: String)
    case error(errMsg: String)
    var message: String {
        switch self {
        case .unsafelyWrapped(let target): return "😱 \(target) cannot be safely unwrapped..."
        case .nil(let target): return "😱 \(target) is nil..."
        case .network(let errMsg): return "😱 http communication failed...\n Message: \(errMsg)"
        case .error(let msg): return "😱 something went wrong... \n Message: \(msg)"
        }
    }
}

