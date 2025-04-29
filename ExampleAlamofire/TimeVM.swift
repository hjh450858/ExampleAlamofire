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
    
    var timeZoneRelay = PublishRelay<TimeZoneData>()
    var timeZoneErrorEvent = PublishSubject<Error>()
    
    var coordinateRelay = PublishRelay<TimeZoneData>()
    var coordinateErrorEvent = PublishSubject<Error>()
    
    var ipRelay = PublishRelay<TimeZoneData>()
    var ipErrorEvent = PublishSubject<Error>()
    
    
    
    func getTimeZoneData(zone: String) {
        print("getTimeZoneData - zone = \(zone)")
        TimeAPIService.getTimeZoneWithZone(zone: zone, relay: timeZoneRelay, errorSubject: timeZoneErrorEvent)
        
    }
    
}
