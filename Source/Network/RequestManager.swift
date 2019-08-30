//
//  RequestManager.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation
import Alamofire

public typealias APICompletion = (NetworkResult) -> Void
public typealias JSONClosure = ([String: Any]?) -> Void

public class RequestManager: NSObject {
    
    
    public static func request(with request: TLSRequest,
                 _ user: User? = nil,
                 completionHandler completion: @escaping APICompletion) {

        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            completion(.error(message: "\(#function), 😱 url is nil"))
            return
        }
        
        var header = [String: String]()
        if let token = user?.token { header = ["authorization": token] }
        
        Alamofire.request(url, method: request.type,
                          parameters: request.body?.data,
                          encoding: JSONEncoding.default,
                          headers: header).response { (res) in
                            
            if let error = res.error {
                Logger.showError(at: #function, type: .network(errMsg: error.localizedDescription))
                completion(.error(message: error.localizedDescription))
                return
            }

            self.evaluateResponse(by: request, with: res, user, completion)
        }
    }
    
    private static func evaluateResponse(by request: TLSRequest,
                                        with dataRes: DefaultDataResponse,
                                        _ user: User?,
                                        _ completion: @escaping APICompletion) {
        
        guard let statusCode = dataRes.response?.statusCode else {
            completion(.error(message: "😱 statusCode is nil"))
            return
        }

        switch statusCode {
        case 200: completion(.sucfulyFetched(data: dataRes.data))
        case 201: completion(.sucfulySent(data: dataRes.data))
        case 202: completion(.accepted)
        case 400: completion(.unknown)
        case 401: completion(.notAuthorised)
        case 406: completion(.notPermitted)
        case 419:
            guard let user = user else {
                completion(.error(message: "\(#function) 😱 user is nil..."))
                return
            }
            renewToken(with: request, of: user) { (isSucsful, newToken) in
                guard isSucsful else {
                    completion(.error(message: "\(#function) 😱 token renewal has failed... "))
                    return
                }

                completion(.tryAgain(with: newToken))
            }
        case 500: completion(.serverError)
        default: return
        }
    }

    private typealias TokenRenewalResult = (isSuccessful: Bool, newToken: String?)
    
    private static func renewToken(with request: TLSRequest,
                           of user: User,
                           completionHandler completion: @escaping ((TokenRenewalResult) -> Void)) {
    
        Alamofire.request(request.tokenRenewalURL,
                          method:request.type,
                          parameters: ["clientSecretKey": user.clientSecret],
                          encoding: JSONEncoding.default,
                          headers: nil)

            .response { (res) in
                let statusCode = res.response?.statusCode

                if let _ = res.error {
                    completion((false, nil))
                    return
                }

                guard let data = res.data else {
                    completion((false, nil))
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion((false, nil))
                    return
                }

                if statusCode == 200 {
                    completion((true, json["token"] as? String))
                    return
                }

                completion((false, nil))
        }
    }
    
    
    /// HTTP 서버통신 결과를 완료해주는 함수 - Generic 데이터 모델 리턴
    ///
    /// - Parameters:
    ///   - apiResult: 통신 결과
    ///   - successAction: 성공했을 때
    ///   - tryAgainAction: 토큰 갱신 후 리턴
    public static func evaluate<T: Decodable>(by result: NetworkResult,
                                              _ successAction: ((T?) -> Void)?,
                                              _ failureAction: ((NetworkResult) -> Void)?,
                                              _ tryAgainAction: (() -> Void)? = nil) {
        
        switch result {
        case .error(let message):
            Logger.showError(at: #function, type: .network(errMsg: message))
            failureAction?(result)
        case .unknown:
            Logger.showError(at: #function, type: .network(errMsg: "unknown error"))
            failureAction?(result)
        case .notAuthorised:
            Logger.showError(at: #function, type: .network(errMsg: "not authorised"))
            failureAction?(result)
        case .notFound:
            Logger.showError(at: #function, type: .network(errMsg: "no params sent with"))
            failureAction?(result)
        case .sucfulyFetched(_):
            successAction?(result.model())
        case .sucfulySent(_):
            successAction?(result.model())
        case .accepted:
            successAction?(nil)
        case .serverError:
            Logger.showError(at: #function, type: .network(errMsg: "server error"))
            failureAction?(result)
        case .tryAgain:
            tryAgainAction?()
        case .notPermitted:
            Logger.showError(at: #function, type: .network(errMsg: "not permitted"))
            failureAction?(result)
        }
    }
    
    /// HTTP 서버통신 결과를 완료해주는 함수 - JSON 리턴
    ///
    /// - Parameters:
    ///   - apiResult: 통신 결과
    ///   - successAction: 성공했을 때
    ///   - tryAgainAction: 토큰 갱신 후 리턴
    public static func evaluate(by result: NetworkResult,
                                _ successAction: JSONClosure?,
                                _ failureAction: ((NetworkResult) -> Void)?,
                                _ tryAgainAction: (() -> Void)? = nil) {
        
        switch result {
        case .error(let message):
            Logger.showError(at: #function, type: .network(errMsg: message))
            failureAction?(result)
        case .unknown:
            Logger.showError(at: #function, type: .network(errMsg: "unknown error"))
            failureAction?(result)
        case .notAuthorised:
            Logger.showError(at: #function, type: .network(errMsg: "not authorised"))
            failureAction?(result)
        case .notFound:
            Logger.showError(at: #function, type: .network(errMsg: "no params sent with"))
            failureAction?(result)
        case .sucfulyFetched:
            successAction?(result.json)
        case .sucfulySent:
            successAction?(result.json)
        case .accepted:
            successAction?(nil)
        case .serverError:
            Logger.showError(at: #function, type: .network(errMsg: "server error"))
            failureAction?(result)
        case .tryAgain:
            Logger.showDebuggingMessage(at: #function, "Your token has expired... Try again!")
            tryAgainAction?()
        case .notPermitted:
            failureAction?(result)
        }
    }

}
