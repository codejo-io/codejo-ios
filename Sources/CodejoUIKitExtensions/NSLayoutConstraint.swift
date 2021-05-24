//
//  NSLayoutConstraint.swift
//  Codejo
//
//  Created by Cole James on 12/9/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {

    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
    
}
