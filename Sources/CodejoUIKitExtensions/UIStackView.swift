//
//  UIStackView.swift
//  Codejo
//
//  Created by Cole James on 4/15/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIStackView

public extension UIStackView {

    func removeAllArrangedSubviews() {
        for item in arrangedSubviews {
            removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            self.addArrangedSubview(view)
        }
    }

}
