//
//  UIToolbar.swift
//  Codejo
//
//  Created by Cole James on 5/23/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIToolbar

public extension UIToolbar {

    static func simpleToolbar(doneButton: UIBarButtonItem) -> UIToolbar {
        let barAccessory = UIToolbar()

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = doneButton
        btnDone.accessibilityIdentifier = "SurveyQuestion_DoneDate_Button"

        barAccessory.barStyle = .default
        barAccessory.isTranslucent = true
        barAccessory.sizeToFit()

        barAccessory.items = [spaceButton, btnDone]
        barAccessory.isUserInteractionEnabled = true

        return barAccessory
    }

}
