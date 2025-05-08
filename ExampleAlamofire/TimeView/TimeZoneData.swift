//
//  TimeZoneData.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 4/29/25.
//

import Foundation

// TimeZone 데이터
struct TimeZoneData: Codable, CustomStringConvertible {
    let year, month, day, hour: Int
    let minute, seconds, milliSeconds: Int
    let dateTime, date, time, timeZone: String
    let dayOfWeek: String
    let dstActive: Bool
    
    var description: String {
        return """
        {
          "date": "\(date)",
          "dayOfWeek": "\(dayOfWeek)",
          "time": "\(time)",
          "hour": \(hour),
          "minute": \(minute),
          "seconds": \(seconds),
          "milliSeconds": \(milliSeconds),
          "timeZone": "\(timeZone)",
          "dstActive": \(dstActive),
          "dateTime": "\(dateTime)"
        }
        """
    }
}

