//
//  UIImpactFeedbackGenerator.swift
//  Codejo
//
//  Created by Cole James on 10/8/20.
//  Copyright © 2020 V Shred LLC. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
extension UIImpactFeedbackGenerator {

    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

}
