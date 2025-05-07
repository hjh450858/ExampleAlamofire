//
//  CalculationModel.swift
//  ExampleAlamofire
//
//  Created by 황재현 on 5/7/25.
//

import Foundation

// MARK: - Calculation Current Model
struct CalculationCurrentModel: Codable {
    let timeZone, timeSpan: String
    
    var dictionary: [String: Any] {
        return ["timeZone": timeZone, "timeSpan": timeSpan]
    }
}


// MARK: - Calculation Custom Model
struct CalculationCustomModel: Codable {
    let timeZone, dateTime, timeSpan, dstAmbiguity: String
    
    var dictionary: [String: Any] {
        return ["timeZone": timeZone, "dateTime": dateTime, "timeSpan": timeSpan, "dstAmbiguity": dstAmbiguity]
    }
}


// MARK: - CalculationResponse
struct CalculationResponse: Codable {
    let timeZone, originalDateTime, usedTimeSpan: String
    let calculationResult: CalculationResult
    
    var description: String {
        return """
        {
          "timeZone": "\(timeZone)",
          "originalDateTime": "\(originalDateTime)",
          "usedTimeSpan": "\(usedTimeSpan)",
          "calculationResult": \(calculationResult.description)
        }
        """
    }
}

// MARK: - CalculationResult
struct CalculationResult: Codable {
    let year, month, day, hour: Int
    let minute, seconds, milliSeconds: Int
    let dateTime, date, time: String
    let dstActive: Bool
    
    var description: String {
        return """
        {
          "year": "\(year)",
          "month": "\(month)",
          "day": "\(day)",
          "hour": \(hour),
          "minute": \(minute),
          "seconds": \(seconds),
          "milliSeconds": \(milliSeconds),
          "dateTime": "\(dateTime)",
          "date": \(date),
          "time": "\(time)",
          "dstActive": "\(dstActive)"
        }
        """
    }
}
