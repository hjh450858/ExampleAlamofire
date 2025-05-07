//
//  CalculationRouter.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/2/25.
//

import Foundation
import Alamofire
import SwiftyJSON

enum CalculationRouter: URLRequestConvertible {
    // 증가
    case currentIncrement(current: CalculationCurrentModel)
    // 감소
    case currentDecrement(current: CalculationCurrentModel)
    
    case customIncrement(current: CalculationCustomModel)
    
    case customDecrement(current: CalculationCustomModel)
    
    // 기본 URL
    var baseURL: URL {
        return URL(string: APIClient.BASE_URL + "/api/calculation")!
    }
    
    // 엔드포인트
    var endPoint: String {
        switch self {
        case .currentIncrement:
            return "/current/increment"
        case .currentDecrement:
            return "/current/decrement"
        case .customIncrement:
            return "/custom/increment"
        case .customDecrement:
            return "/custom/decrement"
        }
    }
    
    // 메소드
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    // 파라미터
    var parameters: Parameters {
        switch self {
        case .currentIncrement(let current), .currentDecrement(let current):
            print("parameters = \(current.dictionary)")
            return current.dictionary
            // 파라미터 설정
        case .customIncrement(let custom), .customDecrement(let custom):
            // 파라미터 설정
            return custom.dictionary
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        
        // JSON Encoding
        /*
         body가 JSON 타입을 요구함
         */
        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = jsonData
        
        return request
        
        /*
         // MARK: URLEncoding.default를 쓰면 안되는 이유
         URLEncoding은 URL 쿼리스트링이나 x-www-form-urlencoded 로 인코딩을 함
         서버가 JSON을 기대하는데 이 형식으로 보내면 415 Unsupported Media Type, 400 Bad Request
         또는 파싱 오류가 발생할 수 있음.
         "URLEncoding.default" 은 주로 GET에 쓰임
         */
        
//        switch self {
//        default:
//            request = try URLEncoding.default.encode(request, with: parameters)
//            print("request = \(request)")
//            return request
//        }
    }
}
