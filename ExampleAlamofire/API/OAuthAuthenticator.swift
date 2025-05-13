//
//  OAuthAuthenticator.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/12/25.
//

import Foundation
import Alamofire
import SwiftyJSON

final class OAuthAuthenticator: Authenticator {
    /// 헤더에 인증 추가
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        print("OAuthAuthenticator - apply() called / credential.accessToken: \(credential.accessToken)")
        
        // 헤더에 Authrization 키로 Bearer 토큰값
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    
        // 만약에 커스텀이면
        urlRequest.headers.add(name: "ACCESS_TOKEN", value: credential.accessToken)
    }

    /// 토큰 리프레시
    func refresh(_ credential: OAuthCredential, for session: Session, completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        print("OAuthAuthenticator - refresh() called")
        // MARK: - 여기서 토큰 재발행 API 태우면 됩니다.
    }

    /// API 요청 완료
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        // MARK: - statusCode값이 401이고 Authorization값이 INVALID면
        // MARK: -                      (Authorization 이건 API 스펙에 따라 다름)
        if response.statusCode == 401 && response.headers["Authorization"] == "INVALID" {
            return true
        } else {
            return false
        }
        
        // MARK: stausCode값이 401이면 true 아니면 false
        return response.statusCode == 401
    }
    
    /// 인증이 필요한 urlRequest에 대해서만 refresh가 되도록, 이 경우에만 true를 리턴하여 refresh 요청
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // MARK: - bearerToken의 urlRequest대해서만 refresh를 시도 (true)
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
        
        // MARK: - 매번 refresh를 하고싶을때
        return true
    }
}

/*
 import Alamofire
 import SwiftyJSON

 class OAuthAuthenticator: Authenticator {
     /// 헤더에 인증 추가
     func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
         print("OAuthAuthenticator - apply() called / credential.accessToken: \(credential.accessToken)")
     
         // 헤더에 Authrization 키로 Bearer 토큰값
 //            urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
     
         // 만약에 커스텀이면
         urlRequest.headers.add(name: "ACCESS_TOKEN", value: credential.accessToken)
     }

     /// 토큰 리프레시
     func refresh(_ credential: OAuthCredential,
                  for session: Session,
                  completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
         
         print("OAuthAuthenticator - refresh() called")
         // 여기서 토큰 재발행 api 태우면 됩니다.
         
         let request = session.request(AuthRouter.tokenRefresh)
         
         request
             .responseDecodable(of: BaseResponse<TokenEntity>.self) { result in
             switch result.result {

             case .success(let value):
                 print("value: \(value)")
                 // 재발행 받은 토큰 저장
                 if let data = value.data {
                     UserInfo.shared.updateToken(data)
                 }
                 
                 let expiration = Date(timeIntervalSinceNow: 60 * 60)
                 // 새로운 크리덴셜
                 
                 if let accessToken = value.data?.accessToken {
                     let newCredential = OAuthCredential(accessToken: accessToken,
                                                         refreshToken: UserInfo.shared.refreshToken,
                                                         expiration: expiration)
                     completion(.success(newCredential))
                 }
                 
             case .failure(let error):
                 print("[리프레시토큰 테스트] refreshTokenError : \(error)")
                 
                 #warning("TODO - 로그인 화면으로 이동시키기")
                 
                 let data = ["status": UserInfo.UserType.GUEST]
                 // 사용자 상태 변경 노티피케이션 전송
                 NotificationCenter.default.post(name: .UserInfoState, object: nil, userInfo: data)
                 
                 completion(.failure(error))
             }
         }
         
         // Refresh the credential using the refresh token...then call completion with the new credential.
         //
         // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
         // be authenticated using the `apply(_:to:)` method using the new credential.
     }

     /// api 요청 완료
     func didRequest(_ urlRequest: URLRequest,
                     with response: HTTPURLResponse,
                     failDueToAuthenticationError error: Error) -> Bool {
         
         print("OAuthAuthenticator - didRequest() called / response.statusCode : \(response.statusCode)")
         
         print("OAuthAuthenticator - didRequest() called / response : \(response), response.headers: \(response.headers)")
         
         if  response.statusCode == 401 &&
             response.headers["Authorization"] == "INVALID" {
             print("OAuthAuthenticator - didRequest() - [리프레시 토큰 테스트] 리프래시탐 [O]")
             return true
         } else {
             print("OAuthAuthenticator - didRequest() - [리프레시 토큰 테스트] 리프래시 [X]")
             return false
         }
         
         // 401 코드가 떨어지면 리프레시 토큰으로 액세스 토큰을 재발행 하라고 요청
 //        switch response.statusCode {
 //            case 500: return true
 //            default: return false
 //        }
         
         // If authentication server CANNOT invalidate credentials, return `false`
 //        return false

         // If authentication server CAN invalidate credentials, then inspect the response matching against what the
         // authentication server returns as an authentication failure. This is generally a 401 along with a custom
         // header value.
         // return response.statusCode == 401
     }

     func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
         
         // If authentication server CANNOT invalidate credentials, return `true`
         
         return true

         // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
         // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
         // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
         // return urlRequest.headers["Authorization"] == bearerToken
     }
 }

 */
