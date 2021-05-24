//
//  UILabel.swift
//  Codejo
//
//  Created by Cole James on 6/24/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UILabel

public extension UILabel {

    @IBInspectable var strikeThrough: Bool {
        get {
            return attributedText != nil
        }
        set {
            if newValue {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
                // Must use NSRange for attributed strings
                // swiftlint:disable:next legacy_constructor
                attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

                // Assigning to attributedText clears and sets text
                self.attributedText = attributeString
            } else {
                let text = self.text

                // Assigning to text clears and sets attributedText
                self.text = text
            }
        }
    }

}
