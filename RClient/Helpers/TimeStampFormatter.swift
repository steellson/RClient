//
//  TimeStampFormatter.swift
//  RClient
//
//  Created by Andrew Steellson on 06.10.2023.
//

import Foundation

final class TimeStampFormatter {
    
    static let instance = TimeStampFormatter()
    
    private init() {}
    
    func timestampToTime(fromString string: String) -> String {
        let fullTimeString = String(string.split(separator: "T")[1])
        let timeString = String(fullTimeString.split(separator: ".")[0])
        return timeString
    }
}
