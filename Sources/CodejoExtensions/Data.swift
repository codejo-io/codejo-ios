//
//  Data.swift
//  vshred-ios
//
//  Created by Cole James on 4/15/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
