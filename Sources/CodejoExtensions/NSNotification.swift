//
//  Notifications.swift
//  vshred-ios
//
//  Created by Cole James on 5/17/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let userDidCancelApplePay        = NSNotification.Name("com.vshred.userDidCancelApplePay")
    static let availableProductsDidUpdate   = NSNotification.Name("com.vshred.availableProductsDidUpdate")
    static let programsDidUpdate            = NSNotification.Name("com.vshred.programsDidUpdateNotification")
    static let userDidUpdate                = NSNotification.Name("com.vshred.userDidUpdate")
    static let splashDidLoad                = NSNotification.Name("com.vshred.splashDidLoad")
}
