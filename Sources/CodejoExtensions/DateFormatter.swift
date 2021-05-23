//
//  DateFormatter.swift
//  Codejo
//
//  Created by Cole James on 8/22/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

extension DateFormatter {

    static func getReadableDate(timeStamp: String, format: String = "MMMM dd, yyyy", withTimeStamp: Bool = true, timeZone: String? = "UTC") -> String? {
        let formatter = DateFormatter()

        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        if let timeZoneAbbrivation = timeZone {
            formatter.timeZone = TimeZone(abbreviation: timeZoneAbbrivation)
        }

        if let date = formatter.date(from: timeStamp) {
            formatter.dateFormat = "MMMM dd, yyyy"
            if withTimeStamp { formatter.dateFormat += "  h:mm a" }
            formatter.timeZone = .current
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "YYYY-MM-dd"
            if let date = formatter.date(from: timeStamp) {
                formatter.dateFormat = "MMMM dd, yyyy"
                if withTimeStamp { formatter.dateFormat += "  h:mm a" }
                formatter.timeZone = .current
                return formatter.string(from: date)
            } else {
                return nil
            }
        }

    }

    static func stringToDate(timeStamp: String?, timeStampFormat: String = "YYYY-MM-dd HH:mm:ss", timeZone: String = "UTC") -> Date? {
        guard let timeStamp = timeStamp else { return nil }

        let formatter = DateFormatter()

        formatter.dateFormat = timeStampFormat
        formatter.timeZone = TimeZone(abbreviation: timeZone)

        return formatter.date(from: timeStamp)
    }

}
