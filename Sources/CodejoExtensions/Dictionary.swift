//
//  Dictionary.swift
//  Codejo
//
//  Created by Brandon T on 5/10/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

public extension Dictionary {
    // Prefer the values of the L-value
    mutating func l_merge(dict: [Key: Value]){
        for (key, value) in dict where self[key] == nil {
            updateValue(value, forKey: key)
        }
    }
    // Prefer the values of the R-value
    mutating func r_merge(dict: [Key: Value]){
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }

    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            self[key] = value
        }
    }
}
