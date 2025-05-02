//
//  TiemRouter.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import Alamofire


/// Time 관련 라우터
enum TimeRouter: URLRequestConvertible {
    // 나라 위치
    case zone(_ zone: String)
    // 위도 경도
    case coordinate(_ latitude: Float, _ longitude: Float)
    // ip 주소
    case ip(_ address: String)
    
    /// 기본 URL
    var baseURL: URL {
        return URL(string: APIClient.BASE_URL + "/api/time/current")!
    }
    
    /// 경로
    var endPoint: String {
        switch self {
        case .zone:
            return "/zone"
        case .coordinate:
            return "/coordinate"
        case .ip:
            return "/ip"
        }
    }
    
    /// HTTP Method
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    /// 파리미터
    var parameters: Parameters {
        switch self {
        case .zone(let zone):
            return ["timeZone": zone]
        case .coordinate(let latitude, let longitude):
            var parameter = Parameters()
            parameter["latitude"] = latitude
            parameter["longitude"] = longitude
            return parameter
        case .ip(let address):
            var parameter = Parameters()
            parameter["ipAddress"] = address
            return parameter
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        // URL 설정
        let url = baseURL.appendingPathComponent(endPoint)
        // URL Request 설정
        var request = URLRequest(url: url)
        // request 메소드 설정
        request.method = method
        // 메소드에 따른 작업 처리
        switch self {
        // 여기에 있는 것들은 다 .get이기에 하나로 묶음
        default:
            request = try URLEncoding.default.encode(request, with: parameters)
            return request
        }
    }
}


/*
 enum VodRouter: URLRequestConvertible {
     /// VOD 이어보기 조회
     case fetchWatchContinue(_ vodId: String)
     /// VOD 상세조회
     case fetchVodDetail(_ vodId: String)
     /// VOD 조회수/이어보기 캐시 처리
     case watchContinueViewCount(_ request: VodWatchContinueRequest)
     /// VOD 대여 만료기간 갱신
     case refreshVodDetail(_ request: VODID)

     var baseURL: URL {
         return URL(string: ApiClient.BASE_URL + "/vod/detail")!
     }
     
     var endPoint: String {
         switch self {
         case .fetchWatchContinue(let vodId):
             return "/continue/\(vodId)"
         case .fetchVodDetail(let vodId):
             return "/\(vodId)"
         case .watchContinueViewCount:
             return "/continue/viewCount"
         case .refreshVodDetail:
             return "/expire"
         }
     }
     
     var method: HTTPMethod {
         switch self {
         case .fetchWatchContinue, .fetchVodDetail: return .get
         default: return .post
         }
     }
     
     var parameters: Parameters{
         switch self {
         case .watchContinueViewCount(let request):
             return request.dictionary
         case .refreshVodDetail(let request):
             return request.dictionary
         default:
             return Parameters()
         }
     }
     
     func asURLRequest() throws -> URLRequest {
         let url = baseURL.appendingPathComponent(endPoint)
         
         var request = URLRequest(url: url)
         
         request.method = method
         
         switch method {
         case .post:
             request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
             return request
         default:
             request = try URLEncoding.default.encode(request, with: parameters)
             return request
         }
     }
     
     
 }
 */
