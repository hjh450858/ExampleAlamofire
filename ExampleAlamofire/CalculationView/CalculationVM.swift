//
//  CalculationVM.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/7/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


class CalculationVM: NSObject {
    
    var resultData = PublishRelay<String>()
    
    var indicatorRelay = BehaviorRelay<Bool>(value: false)
    
    var currentIncrementRelay = PublishRelay<CalculationResponse>()
    var currentIncrementError = PublishRelay<Error>()
    
    var currentDecrementRelay = PublishRelay<CalculationResponse>()
    var currentDecrementError = PublishRelay<Error>()
    
    var customIncrementRelay = PublishRelay<CalculationResponse>()
    var customIncrementError = PublishRelay<Error>()
    
    var customDecrementRelay = PublishRelay<CalculationResponse>()
    var customDecrementError = PublishRelay<Error>()
}
