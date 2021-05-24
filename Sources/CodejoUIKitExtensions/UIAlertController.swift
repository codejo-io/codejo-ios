//
//  UIAlertController.swift
//  Codejo
//
//  Created by Cole James on 4/16/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIAlertController

public extension UIAlertController {

    func addActions(_ actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }

}
