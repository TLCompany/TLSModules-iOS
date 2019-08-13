//
//  RequestManager.swift
//  tlsmodule
//
//  Created by Justin Ji on 05/07/2019.
//  Copyright © 2019 tlsolution. All rights reserved.
//

import Foundation
import Alamofire


public class RequestManager: NSObject {
    
    typealias APICompletion = (APIResult) -> Void
    
    func request(with request: Request,
                 _ user: User? = nil,
                 completionHandler completion: @escaping APICompletion) {

        guard let url = request.url else {
            showError(#function, type: .unsafelyWrapped(taget: "url"))
            completion(.error(message: "\(#function), 😱 url is nil"))
            return
        }
        
        var header = [String: String]()
        if let token = user?.token { header = ["authorization": token] }
        
        Alamofire.request(url, method: request.type,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: header).response { (res) in
                            
            if let error = res.error {
                self.showError(#function, type: .network(errMsg: error.localizedDescription))
                completion(.error(message: error.localizedDescription))
                return
            }
                            
            self.evaluateResponse(request: request,
                                  dataRes: res,
                                  user: user,
                                  completion: completion)
        }
    }
    
    private func evaluateResponse(request: Request,
                                  dataRes: DefaultDataResponse,
                                  user: User?,
                                  completion: @escaping APICompletion) {
        
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

    typealias TokenRenewalResult = (isSuccessful: Bool, newToken: String?)
    
    private func renewToken(with request: Request,
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

}
