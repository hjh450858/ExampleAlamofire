//
//  BaseInterceptor.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import Alamofire

final class BaseInterceptor: RequestInterceptor {
    // API 호출 직전에 실행
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("@@@ adapt()")
        var request = urlRequest
        
        // 헤더 부분 넣어주기
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        print("@@@ retry()")
        completion(.doNotRetry)
    }
}
