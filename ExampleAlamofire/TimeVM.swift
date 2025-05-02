//
//  TimeVM.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class TimeVM: NSObject {
    
    var resultData = PublishRelay<String>()
    
    var indicatorRelay = BehaviorRelay<Bool>(value: false)
    
    var timeZoneRelay = PublishRelay<TimeZoneData>()
    var timeZoneErrorRelay = PublishRelay<Error>()
    
    var coordinateRelay = PublishRelay<TimeZoneData>()
    var coordinateErrorRelay = PublishRelay<Error>()
    
    var ipRelay = PublishRelay<TimeZoneData>()
    var ipErrorRelay = PublishRelay<Error>()
    
    
    
//    func getTimeZoneData(zone: String) {
//        print("getTimeZoneData - zone = \(zone)")
//        TimeAPIService.getTimeZoneWithZone(zone: zone, relay: timeZoneRelay, errorSubject: timeZoneErrorEvent)
//    }
    
}
