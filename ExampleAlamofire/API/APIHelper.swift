//
//  APIHelper.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/12/25.
//

import Foundation
import Alamofire

final class APIHelper {
    static let shared = APIHelper()
    
    /// 인증 인터셉터 가져오기
    /// - Returns: 인증 인터셉터
    static func getAuthInterceptor() -> AuthenticationInterceptor<OAuthAuthenticator> {
        /// 액세스 토큰 (지금은 없으니 있다 치고 설정)
        let accessToken = "access_token"
        /// 리프레쉬 토큰 (지금은 없으니 있다 치고 설정)
        let refreshToken = "refresh_token"
        
        let credential = OAuthCredential(accessToken: accessToken,
                                         refreshToken: refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 60))
        // Create the interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
        
        return authInterceptor
    }
}

/*
 /// 인증 인터셉터 가져오기
 /// - Returns: 인증 인터셉터
 static func getAuthInterceptor() -> AuthenticationInterceptor<OAuthAuthenticator> {
     print("APIHelper - getAuthInterceptor() called")
     /// 액세스 토큰
//        let accessToken = UserInfo.shared.accessToken
     let accessToken = "access_token"
     print("APIHelper - getAuthInterceptor() - accessToken = \(accessToken)")
     /// 리프레쉬 토큰
//        let refreshToken = UserInfo.shared.refreshToken
     let refreshToken = "refresh_token"
     print("APIHelper - getAuthInterceptor() - refreshToken = \(refreshToken)")
     
     let credential = OAuthCredential(accessToken: accessToken,
                                      refreshToken: refreshToken,
                                      expiration: Date(timeIntervalSinceNow: 60 * 60))
     print("APIHelper - getAuthInterceptor() - credential = \(credential)")
     // Create the interceptor
     let authenticator = OAuthAuthenticator()
     let authInterceptor = AuthenticationInterceptor(authenticator: authenticator, credential: credential)
     print("APIHelper - getAuthInterceptor() - authInterceptor.credential?.accessToken = \(authInterceptor.credential?.accessToken)")
     print("APIHelper - getAuthInterceptor() - authInterceptor.credential?.refreshToken = \(authInterceptor.credential?.refreshToken)")
     
     return authInterceptor
 }
}
 */
