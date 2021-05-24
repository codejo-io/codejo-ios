//
//  UITextField.swift
//  Codejo
//
//  Created by Cole James on 5/24/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UITextField

public extension UITextField {

    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

    @IBInspectable var placeholderColor: UIColor? {
        get {
            return nil
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

}
