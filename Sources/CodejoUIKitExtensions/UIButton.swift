//
//  UIButton.swift
//  vshred-ios
//
//  Created by Cole James on 4/11/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIButton

extension UIButton {

    @IBInspectable var adjustsFontSizeToWidth: Bool {
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
    }

    @IBInspectable var imageColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.setImageColor(color: newValue)
        }
    }

    func setImageColor(color: UIColor) {
        let origImage = self.imageView?.image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

    func alignImageRight(horizontalOffset: CGFloat) {
        if let titleLabel = self.titleLabel, let imageView = self.imageView {
            // Force the label and image to resize.
            titleLabel.sizeToFit()
            imageView.sizeToFit()
            imageView.contentMode = .scaleAspectFit

            // Set the insets so that the title appears to the left and the image appears to the right.
            // Make the image appear slightly off the top/bottom edges of the button.
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -0.5 * imageView.frame.size.width,
                bottom: 0,
                right: imageView.frame.size.width * 0.5
            )

            self.imageEdgeInsets = UIEdgeInsets(
                top: 4,
                left: self.frame.size.width / 2 + titleLabel.frame.size.width / 2 - horizontalOffset,
                bottom: 4,
                right: -0.5 * self.frame.size.width - titleLabel.frame.size.width / 2 + horizontalOffset
            )
        }
    }

}
