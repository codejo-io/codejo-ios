//
//  UIImageView.swift
//  vshred-ios
//
//  Created by Cole James on 4/11/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {

    func setImageColor(color: UIColor) {
        let origImage = self.image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = color
    }

    @IBInspectable var imageColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.tintColor = newValue
            self.setImageColor(color: newValue)
        }
    }

}
