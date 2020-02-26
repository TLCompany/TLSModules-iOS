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

    private let _request: Request
    private var _user: User?
    private var dataRequest: DataRequest?
    
    public init(request: Request, user: User? = nil) {
        self._request = request
        self._user = user
    }
    
    /**
     HTTP RESTful 요청을 한다.
     - Parameters:
        - errorAction: 요청과 응답시 에러가 발생됬을 때 클로져
        - failureAction: 요청이 실패 시 (응답코드 = 500) 클로져
        - positiveSuccess: 요청 성공, 200번 사이에 응답 결과를 받았을 때의 클로져
        - negativeSuccess: 요청 성공, 400번 사이에 응답 결과를 받았을 때의 클로져
        - retryAction: 요청 성공, 토큰 만료시 클로져
     */
    public func request(errorAction: ((_ errorMessage: String?) -> Void)? = nil,
                        failureAction: ((_ message: String?) -> Void)? = nil,
                        positiveSuccess: ((Int, JSON) -> Void)?,
                        negativeSuccess: ((Int, JSON) -> Void)?,
                        retryAction: (() -> Void)?) {
        
        guard let urlString = self._request.url?.absoluteURL else {
            errorAction?("")
            return
        }
        
        let dataRequest = AF.request(urlString)
        dataRequest.responseJSON { (response) in
            if let error = response.error {
                failureAction?(error.errorDescription)
                return
            }
            
            guard let status = response.response?.statusCode else {
                errorAction?("Status is nil")
                return
            }
            
            guard status != 419 else {
                retryAction?()
                return
            }
            
            guard let data = response.data else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                errorAction?("data is nil")
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON   else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "json"))
                errorAction?("JSONSerialisation has failed")
                return
            }
            
            switch status {
            case 200...299: positiveSuccess?(status, json)
            case 400...499: positiveSuccess?(status, json)
            default: errorAction?("invalid status")
            }
        }
    }
    
    
    /**
     바이너리 데이터 타입의 첨부와 함께 요청을 한다.
     - Parameters:
        - request: 요청 데이터 모델
        - user: User 데이터 모델
        - attachments: DataAttachment 모델의 배열
        - completionAction: 요청 완료시 클로져 함수
     */
    public static func request(request: Request,
                              user: User? = nil,
                              attachments: [DataAttachment],
                              completionHandler completeAction: ((_ isSuccessful: Bool, _ body: JSON?) -> Void)?) {
        
        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            return
        }
       
         var headerDictionary = [String: String]()
        if let token = user?.token { headerDictionary = ["authorization": token] }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            attachments.enumerated().forEach {
                multipartFormData.append($0.element.data, withName: $0.element.name, fileName: $0.element.fileName, mimeType: $0.element.type.text)
            }
        }, to: url.absoluteString, method: .post, headers: HTTPHeaders.init(headerDictionary))
            .responseJSON { (response) in
                guard let data = response.data else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                    completeAction?(false, nil)
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]   else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "json"))
                    completeAction?(false, nil)
                    return
                }
                
                completeAction?(true, json)
        }
    }
    
    /**
     로컬에 저장되어 있는  미디어 파일 URL의 첨부와 함께 요청을 한다.
     - Parameters:
        - request: 요청 데이터 모델
        - user: User 데이터 모델
        - attachments: URLAttachment 모델의 배열
        - completionAction: 요청 완료시 클로져 함수
     */
    public static func request(request: Request,
                              user: User? = nil,
                              attachments: [URLAttachment],
                              completionHandler completeAction: ((_ isSuccessful: Bool, _ body: JSON?) -> Void)?) {
        
        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            return
        }
       
         var headerDictionary = [String: String]()
        if let token = user?.token { headerDictionary = ["authorization": token] }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            attachments.enumerated().forEach {
                multipartFormData.append($0.element.url, withName: $0.element.name, fileName: $0.element.fileName, mimeType: $0.element.type.text)
            }
        }, to: url.absoluteString, method: .post, headers: HTTPHeaders.init(headerDictionary))
            .responseJSON { (response) in
                guard let data = response.data else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                    completeAction?(false, nil)
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]   else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "json"))
                    completeAction?(false, nil)
                    return
                }
                
                completeAction?(true, json)
        }
    }
    
    @available(*, deprecated, message: "as Alamofire is updated up to 5.0.0, this function is not supported.")
    public static func upload(with request: Request,
                              _ user: User? = nil,
                              urls: [URL],
                              mediumType: MediumType,
                              completionHandler completeAction: ((_ isSuccessful: Bool, _ body: [String: Any]?) -> Void)?) {
       
        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            return
        }
       
         var headerDictionary = [String: String]()
        if let token = user?.token { headerDictionary = ["authorization": token] }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            urls.enumerated().forEach {
                multipartFormData.append($0.element, withName: "Files", fileName: "imageData", mimeType: mediumType.text)
            }
        }, to: url.absoluteString, method: .post, headers: HTTPHeaders.init(headerDictionary))
            .responseJSON { (response) in
                guard let data = response.data else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                    completeAction?(false, nil)
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]   else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "json"))
                    completeAction?(false, nil)
                    return
                }
                
                completeAction?(true, json)
        }
    }
       
    @available(*, deprecated, message: "as Alamofire is updated up to 5.0.0, this function is not supported.")
    public static func upload(with request: Request,
                              _ user: User? = nil,
                               dataArray: [Data],
                               mediumType: MediumType,
                               completionHandler completeAction: ((_ isSuccessful: Bool, _ body: [String: Any]?) -> Void)?) {
       
        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            return
        }
       
         var headerDictionary = [String: String]()
        if let token = user?.token { headerDictionary = ["authorization": token] }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            dataArray.enumerated().forEach {
                multipartFormData.append($0.element, withName: "Files", fileName: "imageData", mimeType: mediumType.text)
            }
        }, to: url.absoluteString, method: .post, headers: HTTPHeaders.init(headerDictionary))
            .responseJSON { (response) in
                guard let data = response.data else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "data"))
                    completeAction?(false, nil)
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]   else {
                    Logger.showError(at: #function, type: .unsafelyWrapped(taget: "json"))
                    completeAction?(false, nil)
                    return
                }
                
                completeAction?(true, json)
        }
    }
    
    /**
     기본적인 RESTful 요청을 한다.
     - Parameters:
        - request: 요청 데이터 모델
        - user: User 데이터 모델
        - completion: 요청 완료시 클로져 함수
     */
    public static func request(with request: Request,
                               _ user: User? = nil,
                               completionHandler completion: @escaping APICompletion) {

        guard let url = request.url else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "url"))
            completion(.error(message: "\(#function), 😱 url is nil"))
            return
        }
        
        var headerDictionary = [String: String]()
        if let token = user?.token { headerDictionary = ["authorization": token] }
        
        AF.request(url, method: request.type,
                          parameters: request.body?.data,
                          encoding: JSONEncoding.default,
                          headers: HTTPHeaders.init(headerDictionary)).response { (res) in
                            
            if let error = res.error {
                Logger.showError(at: #function, type: .network(errMsg: error.localizedDescription))
                completion(.error(message: error.localizedDescription))
                return
            }
                            
            self.evaluateResponse(by: request, with: res, user, completion)
        }
    }
    
    private static func evaluateResponse(by request: Request,
                                        with dataRes: AFDataResponse<Data?>,
                                        _ user: User?,
                                        _ completion: @escaping APICompletion) {
        
        guard let statusCode = dataRes.response?.statusCode else {
            completion(.error(message: "😱 statusCode is nil"))
            return
        }
        guard let data = dataRes.data else {
            completion(.error(message: "😱 data is nil"))
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
            completion(.error(message: "😱 json is nil"))
            return
        }
        
        guard let message = json["message"] as? String else {
            completion(.error(message: "😱 message is nil"))
            return
        }
        
        switch statusCode {
        case 200: completion(.success(message: message, data: dataRes.data))
        case 201: completion(.sucfulyDataModified(message: message, data: dataRes.data))
        case 400: completion(.invalidRequest(message: message))
        case 401: completion(.failure(message: message))
        case 403: completion(.notAuthroised(message: message))
        case 404: completion(.noData(message: message))
        case 409: completion(.cannotWrite(message: message))
        case 419: completion(.tokenExpired)
        case 500: completion(.serverError(message: message))
        default: return
        }
    }

    public typealias TokenRenewalResult = (isSuccessful: Bool, newToken: String?)
    
    public static func renewToken(with request: Request,
                           of user: User,
                           completionHandler completion: @escaping ((TokenRenewalResult) -> Void)) {
        
        AF.request(request.tokenRenewalURL,
                          method: .post,
                          parameters: ["Data": ["clientSecretKey": user.clientSecret]],
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

                if statusCode == 200, let dataJSON = json["Data"] as? [String: Any], let token = dataJSON["token"] as? String {
                    completion((true, token))
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
                                              sAction successAction: ((T?) -> Void)?,
                                              fAction failureAction: ((String?) -> Void)?,
                                              tAction tryAgainAction: (() -> Void)? = nil) {
        
        switch result {
        case .success, .sucfulyDataModified:
            successAction?(result.model())
        case .tokenExpired:
            tryAgainAction?()
        default: failureAction?(result.errorMessage)
        }
    }
    
    /// HTTP 서버통신 결과를 완료해주는 함수 - JSON 리턴
    ///
    /// - Parameters:
    ///   - apiResult: 통신 결과
    ///   - successAction: 성공했을 때
    ///   - tryAgainAction: 토큰 갱신 후 리턴
    public static func evaluate(by result: NetworkResult,
                                sAction successAction: JSONClosure?,
                                fAction failureAction: ((String?) -> Void)?,
                                tAction tryAgainAction: (() -> Void)? = nil) {
        
           switch result {
            case .success, .sucfulyDataModified:
                successAction?(result.json)
            case .tokenExpired:
                tryAgainAction?()
            default: failureAction?(result.errorMessage)
        }
    }

}
