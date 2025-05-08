//
//  CalculationAPIService.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/7/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


enum CalculationAPIService {
    // MARK: - current + API
    static func postCalculationCurrentIncrement(model: CalculationCurrentModel, relay: PublishRelay<CalculationResponse>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(CalculationRouter.currentIncrement(current: model))
            .validate()
            .responseDecodable(of: CalculationResponse.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(data)
                case .failure(let error):
                    errorRelay.accept(error)
                }
            }
    }
    
    // MARK: - current - API
    static func postCalculationCurrentDecrement(model: CalculationCurrentModel, relay: PublishRelay<CalculationResponse>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(CalculationRouter.currentDecrement(current: model))
            .validate()
            .responseDecodable(of: CalculationResponse.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(data)
                case .failure(let error):
                    errorRelay.accept(error)
                }
            }
    }
    
    // MARK: - custom + API
    static func postCalculationCustomIncrement(model: CalculationCustomModel, relay: PublishRelay<CalculationResponse>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(CalculationRouter.customIncrement(current: model))
            .validate()
            .responseDecodable(of: CalculationResponse.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(data)
                case .failure(let error):
                    errorRelay.accept(error)
                }
            }
    }
    
    // MARK: - custom - API
    static func postCalculationCustomDecrement(model: CalculationCustomModel, relay: PublishRelay<CalculationResponse>, errorRelay: PublishRelay<Error>) {
        APIClient.shared.session
            .request(CalculationRouter.customDecrement(current: model))
            .validate()
            .responseDecodable(of: CalculationResponse.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(data)
                case .failure(let error):
                    errorRelay.accept(error)
                }
            }
    }
    
    // MARK: Return PublishRelay<Result<CalculationResponse, Error>>
    /*
     static func postCalculationCustomIncrement랑 동일함
     */
    static func postCalculationCustomIncrementReturnRelay(model: CalculationCustomModel) -> PublishRelay<Result<CalculationResponse, Error>> {
        let relay = PublishRelay<Result<CalculationResponse, Error>>()
        
        APIClient.shared.session.request(CalculationRouter.customIncrement(current: model))
            .validate()
            .responseDecodable(of: CalculationResponse.self) { response in
                switch response.result {
                case .success(let data):
                    relay.accept(.success(data))
                case .failure(let error):
                    relay.accept(.failure(error))
                }
            }
        return relay
    }
}
