//
//  Character.swift
//  vshred-ios
//
//  Created by Cole James on 2/19/20.
//  Copyright © 2020 V Shred LLC. All rights reserved.
//

import Foundation

extension Character {

    func isNumberCharacter() -> Bool {
        return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(self)
    }

}
