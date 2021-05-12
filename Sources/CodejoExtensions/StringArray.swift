//
//  StringArray.swift
//  vshred-ios
//
//  Created by Cole James on 1/29/20.
//  Copyright © 2020 V Shred LLC. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == (String) {

    func commaDelimited(prependString: String? = nil) -> String {
        var string = ""

        if let prependString = prependString {
            string.append("\(prependString)")
            if count > 0 {
                string.append(",")
            }
        }

        for (index, el) in self.enumerated() {
            string.append("\(el)")
            if index != self.count - 1 {
                string.append(",")
            }
        }
        return string
    }

}
