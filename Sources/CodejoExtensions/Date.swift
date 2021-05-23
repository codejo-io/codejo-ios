//
//  Date.swift
//  Codejo
//
//  Created by Cole James on 4/6/20.
//  Copyright © 2020 V Shred LLC. All rights reserved.
//

import Foundation

extension Date {

    static var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: Date())
    }

    static var shortYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY"
        return dateFormatter.string(from: Date())
    }

    static var fullYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: Date())
    }

}
