//
//  DispatchQueue.swift
//  Codejo
//
//  Created by Cole James on 4/17/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

    static func serialBackground(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        let serialQueue = DispatchQueue(label: "background")
        serialQueue.async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

    static func timeout(_ delay: Double, _ process: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            process()
        }
    }

}
