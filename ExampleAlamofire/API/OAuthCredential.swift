//
//  OAuthCredential.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/12/25.
//

import Foundation
import Alamofire


struct OAuthCredential: AuthenticationCredential {
    /// 액세스 토큰
    let accessToken: String
    /// 리프레쉬 토큰
    let refreshToken: String
    /// 만료
    let expiration: Date
    /// 유효시간이 앞으로 5분 이하 남았다면 refresh가 필요하다고 true를 리턴 (false를 리턴하면 refresh 필요x)
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
    
}
