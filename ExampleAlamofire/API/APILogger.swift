//
//  ApiLogger.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import Alamofire

// API 모니터
final class APILogger: EventMonitor {
    // 1. 직렬 큐 설정
    let queue = DispatchQueue(label: "com.exampleAlamofire.networkLogger")
    
    // 2. 네트워크 요청이 시작되었을 때
    func requestDidResume(_ request: Request) {
        print("APILogger - requestDidResume() called - request = \(request.description)")
    }
    
    // 3. 응답을 받은 후 Alamofire가 응답 데이터를 파싱한 직후 호출
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("APILogger - request() - called - response = \(response.description)")
        
        if let error = response.error {
            print("APILogger - request() - if let error = \(error)")
            // MARK: 해당 에러별 분기처리
            switch error {
            case .sessionTaskFailed(let error):
                print("APILogger - request() - error - .sessionTaskFailed - error = \(error)")
                if error._code == NSURLErrorTimedOut {
                    print("APILogger - request() - error - .sessionTaskFailed - API 타임아웃")
                }
            case .explicitlyCancelled:
                print("APILogger - request() - error - .explicitlyCancelled - 취소가 되었다")
            default:
                print("APILogger - request() - error - default")
            }
        }
        debugPrint(response)
    }
}


/*
 // API 모니터
 final class APILogger: EventMonitor {
     
 //    let queue = DispatchQueue(label: "going")
     
     // Event called when any type of Request is resumed.
     func requestDidResume(_ request: Request) {
         print("ApiLogger - requestDidResume() called - request = \(request)")
     }
     
     // Event called whenever a DataRequest has parsed a response.
     func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
         print("ApiLogger - request() - called - response = \(response)")
         
         if let error = response.error {
             print("ApiLogger - request() - if let error = \(error)")
             switch error {
             case .sessionTaskFailed(let error):
                 print("ApiLogger - request() - error - .sessionTaskFailed - error = \(error)")
                 if error._code == NSURLErrorTimedOut {
                     print("ApiLogger - request() - error - .sessionTaskFailed - [API 타임아웃 테스트] Time out occurs! !!!!!")
                     // 타임아웃 에러 팝업을 띄운다.
 //                    self.sendRequestTimeoutNotification()
                 }
             case .explicitlyCancelled:
                 print("ApiLogger - request() - error - .explicitlyCancelled - 취소가 되었다")
             default:
                 print("ApiLogger - request() - error - default")
             }
         }
         debugPrint(response)
         
     }
 }

 //MARK: - Notification
 extension APILogger {
     
     /// 리퀘스트 타임아웃 에러 보내기
     fileprivate func sendRequestTimeoutNotification() {
         print("ApiLogger - sendRequestTimeoutNotification() called")
         
         let data = ["msg" : "requestTimeout"]
         
 //        NotificationCenter.default.post(name: .RequestTimeOut, object: nil, userInfo: nil)
         
     }
 }

 */
