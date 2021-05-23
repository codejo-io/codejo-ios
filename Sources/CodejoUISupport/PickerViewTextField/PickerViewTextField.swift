//
//  File.swift
//  
//
//  Created by Cole James on 5/23/21.
//

import UIKit

class PickerViewTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerView = UIPickerView()

    var options: [PickerViewTextFieldOption] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPickerView()
    }

    private func setupPickerView() {
        pickerView = UIPickerView()
        pickerView.delegate = self

        setupBarAccessory()

        inputView = pickerView
    }

    private func setupBarAccessory() {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDoneButtonTap))

        let barAccessory = UIToolbar()

        barAccessory.barStyle = .default
        barAccessory.isTranslucent = true
        barAccessory.sizeToFit()

        barAccessory.items = [spaceButton, btnDone]
        barAccessory.isUserInteractionEnabled = true

        inputAccessoryView = barAccessory
    }

    @objc func onDoneButtonTap() {
        resignFirstResponder()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].text
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if options[row].enabled {
            text = options[row].text
        } else {
            pickerView.selectRow(row + 1, inComponent: component, animated: true)
        }
    }

}