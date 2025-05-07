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
}
