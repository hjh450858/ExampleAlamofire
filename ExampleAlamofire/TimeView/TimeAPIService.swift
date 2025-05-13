//
//  TimeAPIService.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa



enum TimeAPIService {
    /// 검색 위치 해당 데이터 가져오기
    static func getTimeZone(zone: String) -> Observable<TimeZoneData> {
        return Observable.create { observer in
            let request = APIClient.shared.session
                // 만들어놓은 Router로 request
                .request(TimeRouter.zone(zone))
                // 코드값이 설정해 놓은 값 안에 있을때만 받음
                .validate(statusCode: 200...500)
                // DecodableResponseSerializer를 사용해 서버에서 반환된 데이터를 지정된 DataDecoder을 사용하는 Decodable타입으로 변환
                .responseDecodable(of: TimeZoneData.self) { response in
                    // 결과 값
                    switch response.result {
                    // 성공
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    // 실패
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create() {
                request.cancel()
            }
        }
    }
    
    static func getTimeZoneWithZone(zone: String, relay: PublishRelay<TimeZoneData>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            // MARK: - API에 access_token를 header에 넣을때 필요한 예제
//            .request(TimeRouter.zone(zone), interceptor: APIHelper.getAuthInterceptor())
            .request(TimeRouter.zone(zone))
            .validate()
            // DecodableResponseSerializer를 사용해 서버에서 반환된 데이터를 지정된 DataDecoder을 사용하는 Decodable타입으로 변환
            .responseDecodable(of: TimeZoneData.self) { response in
                switch response.result {
                case .success(let data):
                    print("data = \(data)")
                    relay.accept(data)
                case .failure(let error):
                    print("error = \(error)")
                    errorRelay.accept(error)
                }
            }
    }
    
    static func getTimeZoneWithCoordinate(latitude: Float, longitude: Float, relay: PublishRelay<TimeZoneData>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(TimeRouter.coordinate(latitude, longitude))
            .validate()
            .responseDecodable(of: TimeZoneData.self) { response in
                switch response.result {
                case .success(let data):
                    print("data = \(data)")
                    relay.accept(data)
                case .failure(let error):
                    print("error = \(error)")
                    errorRelay.accept(error)
                }
            }
    }
    
    static func getTimeZoneWithIP(ip: String, relay: PublishRelay<TimeZoneData>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(TimeRouter.ip(ip))
            .validate()
            .responseDecodable(of: TimeZoneData.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(data)
                case .failure(let error):
                    errorRelay.accept(error)
                }
            }
    }
}


/*
 /// VOD_상세화면 정보 가져옴
 static func getVodDetail(vodId: String) -> AnyPublisher<VodDetail, Error> {
     print("VodApiService - getVodDetail() called - vodId = \(vodId)")

     return ApiClient.shared.session
         .request(VodRouter.fetchVodDetail(vodId), interceptor: SGUtils.getAuthInterceptor())
         .publishDecodable(type: BaseResponse<VODDetailEntity>.self)
         .value()
         .mapError({ (afError: AFError) -> SG_API_ERROR in
             print("VodApiService - getVodDetail() - mapError - afError = \(afError)")
             return SG_API_ERROR.UNKNOWN_ERROR(afError)
         })
         .tryMap { (receivedValue: BaseResponse<VODDetailEntity>) in
             print("VodApiService - getVodDetail() - tryMap - receivedValue = \(receivedValue)")
             switch receivedValue.status {
             case 200:
                 guard let data = receivedValue.data else { throw SG_API_ERROR.NOT_CODE_ERROR(receivedValue.message) }
                 return VodDetail(data)
             default:
                 guard let code = Int(receivedValue.code ?? "") else { throw SG_API_ERROR.NOT_CODE_ERROR(receivedValue.message) }
                 throw SG_API_ERROR.initialize(code)
             }
         }
         .eraseToAnyPublisher()
 }
 
 
 
 /// 리프레쉬토큰으로 액세스토큰 교환
 func changeAccessToken(refreshToken: String, completion: @escaping(Result<String, SC_API_SERVER_ERROR>) -> Void) {
     print("AlamofireManager - changeAccessToken() called - refreshToken = \(refreshToken)")

     self.session.request(AuthRouter.exchangeToken)
         .validate(statusCode: 200...400)
         .responseJSON { result in
             switch result.result {
             case .success(let value):
                 print("AlamofireManager - changeAccessToken() - valeu = \(value)")
                 
                 let json = JSON(value)
                 print("AlamofireManager - changeAccessToken() - json = \(json)")
                 
                 let status = json["status"].intValue
                 print("AlamofireManager - changeAccessToken() - status = \(status)")
                 let jsonData = json["data"]
                 UserInfo.shared.updateAccessToken(newValue: jsonData["accessToken"].stringValue)
                 
                 completion(.success(UserInfo.shared.accessToken))
                 
             case .failure(let error):
                 print("AlamofireManager - changeAccessToken() - error = \(error)")
                 completion(.failure(.unknownError(message: error.localizedDescription)))
             }
         }
 }
 */
