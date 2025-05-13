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
        var request = urlRequest
        
        // 헤더 부분 넣어주기
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        // TODO: API 구조에 맞게 토큰이 필요하면 토큰을 가져오고 헤더에 넣어줌 분기처리
        // MARK: - OAuthAuthenticator에서 토큰을 넣어주고 있으므로 안써도 된다.
//        request.addValue("Bearer ACCESS_TOKEN", forHTTPHeaderField: "Authorization")
        
        completion(.success(request))
    }
    
    // 재시도
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        // 인증 오류 시 토큰 갱신 후 재시도
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            // TODO: - 토큰 갱신 코드 후 갱신 성공하면 .retry 실패하면 .doNotRetryWithError
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}
