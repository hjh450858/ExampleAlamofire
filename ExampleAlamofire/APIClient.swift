//
//  APIClient.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import Alamofire


/// API 클라이언트
final class APIClient {
    /// 싱글톤
    static let shared = APIClient()
    /// 메인 루트
    static var ROOT = "https://timeapi.io"
    
    static var BASE_URL = ROOT
    
    var session: Session
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor()
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    init() {
        // 세선에 인터셉터 및 모니터 주입
        self.session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}


/*
 /// api 호출 클라이언트
 final class ApiClient {
     
     static let shared = ApiClient()
     
     static var VERSION : String = UserDefaultsManager.shared.getTestServer() ? "/v2" : "/v3"
     static var ROOT =
 //    "https://staby.ngrok.io"
     UserDefaultsManager.shared.getTestServer() ? "https://going-api-dev.staby.co.kr" : "https://going-api.staby.co.kr"
     static var BASE_URL = ROOT + VERSION
     
     ///채널톡 주소
     static let CHAT_BOT_URL = "https://going.channel.io"
     
     let interceptors = Interceptor(interceptors: [
         BaseInterceptor() // application/json
     ])
     
     let monitors = [ApiLogger()] as [EventMonitor]
     
     var session: Session
     
     init() {
         print("ApiClient - init() called")
         session = Session(interceptor: interceptors, eventMonitors: monitors)
     }
     
     func updateURL(_ isTestServer: Bool) {
         if isTestServer {
             ApiClient.VERSION = "/v2"
             ApiClient.ROOT = "https://going-api-dev.staby.co.kr"
         } else {
             ApiClient.VERSION = "/v3"
             ApiClient.ROOT = "https://going-api.staby.co.kr"
         }
 //        ApiClient.ROOT = "https://staby.ngrok.io"
         
         ApiClient.BASE_URL = ApiClient.ROOT + ApiClient.VERSION
     }
 }

 */
