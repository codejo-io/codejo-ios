//
//  Array.swift
//  Codejo
//
//  Created by Cole James on 11/25/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

extension Array {

    func first(_ numberOfItems: Int) -> Self {
        let length = self.count >= numberOfItems ? numberOfItems - 1 : self.count - 1

        if count > 0 {
            return Array(self[0...length])
        } else {
            return []
        }
    }

    mutating func removeDuplicates( includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) {
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }

        self = results
    }
}
